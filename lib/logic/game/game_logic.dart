/// Main Game Logic Engine
/// محرك منطق اللعبة الرئيسي
library;

import 'package:b_brane/models/difficulty.dart';
import 'package:b_brane/models/game_mode.dart';
import 'package:b_brane/models/game_link_question.dart';
import 'package:b_brane/models/game_answer.dart';
import 'package:b_brane/logic/game/scoring_engine.dart';
import 'package:b_brane/logic/game/anti_cheat_service.dart';

class GameLogic {
  /// Current game session ID
  late String _sessionId;

  /// Current questions
  List<GameLinkQuestion> _questions = [];

  /// Current answers
  List<GameAnswer> _answers = [];

  /// Game configuration
  late GameMode _gameMode;
  late Difficulty _difficulty;
  late int _totalQuestions;

  /// Game state
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  int _totalScore = 0;
  DateTime? _sessionStartTime;
  DateTime? _sessionEndTime;

  /// Anti-cheat service
  final AntiCheatService _antiCheatService = AntiCheatService();

  /// Getters
  GameLinkQuestion? get currentQuestion =>
      _currentQuestionIndex < _questions.length
      ? _questions[_currentQuestionIndex]
      : null;

  int get currentQuestionIndex => _currentQuestionIndex;
  int get totalQuestions => _totalQuestions;
  int get correctAnswers => _correctAnswers;
  int get totalScore => _totalScore;
  bool get isSessionActive =>
      _sessionStartTime != null && _sessionEndTime == null;
  int get sessionDuration => (_sessionEndTime ?? DateTime.now())
      .difference(_sessionStartTime!)
      .inSeconds;

  /// Initialize game session
  void initializeSession({
    required String sessionId,
    required List<GameLinkQuestion> questions,
    required GameMode gameMode,
    required Difficulty difficulty,
  }) {
    _sessionId = sessionId;
    _questions = questions;
    _gameMode = gameMode;
    _difficulty = difficulty;
    _totalQuestions = questions.length;
    _currentQuestionIndex = 0;
    _correctAnswers = 0;
    _totalScore = 0;
    _answers = [];
    _sessionStartTime = DateTime.now();
    _sessionEndTime = null;

    _antiCheatService.initializeSession(sessionId, sessionId);
  }

  /// Submit answer for current question
  GameAnswer? submitAnswer({
    required String selectedAnswerAr,
    required String selectedAnswerEn,
    required int timeTaken,
  }) {
    final question = currentQuestion;
    if (question == null) return null;

    // Check for cheating
    final cheatLevel = _antiCheatService.checkAnswer(
      playerId: _sessionId,
      questionId: question.id,
      timeTaken: timeTaken,
      timerDuration: _difficulty.getTimerDuration(1),
      isCorrect: selectedAnswerAr == question.correctLinkAr,
      selectedAnswer: selectedAnswerAr,
      correctAnswer: question.correctLinkAr,
    );

    // Reject if critical cheating detected
    if (cheatLevel == SuspiciousActivityLevel.critical) {
      return null;
    }

    // Check correctness
    final isCorrect = selectedAnswerAr == question.correctLinkAr;

    // Calculate points
    final points = ScoringEngine.calculatePoints(
      isCorrect: isCorrect,
      difficulty: _difficulty,
      mode: _gameMode,
      timeTaken: timeTaken,
      timerDuration: _difficulty.getTimerDuration(1),
    );

    // Apply penalty if suspicious
    int finalPoints = points;
    if (cheatLevel == SuspiciousActivityLevel.medium ||
        cheatLevel == SuspiciousActivityLevel.high) {
      finalPoints = (points * 0.5).toInt(); // 50% penalty
    }

    // Create answer object
    final answer = GameAnswer(
      id: question.id,
      sessionId: _sessionId,
      questionId: question.id,
      selectedAnswerAr: selectedAnswerAr,
      selectedAnswerEn: selectedAnswerEn,
      correctAnswerAr: question.correctLinkAr,
      correctAnswerEn: question.correctLinkEn,
      isCorrect: isCorrect,
      timeTaken: timeTaken,
      pointsEarned: finalPoints,
    );

    _answers.add(answer);

    if (isCorrect) {
      _correctAnswers++;
    }

    _totalScore += finalPoints;

    return answer;
  }

  /// Move to next question
  bool nextQuestion() {
    if (_currentQuestionIndex < _totalQuestions - 1) {
      _currentQuestionIndex++;
      return true;
    }
    return false;
  }

  /// Complete session
  Map<String, dynamic> completeSession() {
    _sessionEndTime = DateTime.now();
    _antiCheatService.clearSession(_sessionId);

    return {
      'session_id': _sessionId,
      'game_mode': _gameMode.getModeNumber(),
      'difficulty': _difficulty.toStorageString(),
      'total_questions': _totalQuestions,
      'correct_answers': _correctAnswers,
      'wrong_answers': _totalQuestions - _correctAnswers,
      'total_score': _totalScore,
      'accuracy': (_correctAnswers / _totalQuestions * 100).toStringAsFixed(2),
      'session_duration': sessionDuration,
      'answers': _answers.map((a) => a.toJson()).toList(),
      'started_at': _sessionStartTime?.toIso8601String(),
      'completed_at': _sessionEndTime?.toIso8601String(),
    };
  }

  /// Get game statistics
  Map<String, dynamic> getGameStatistics() {
    final totalTime = sessionDuration;
    final avgTimePerQuestion =
        totalTime ~/ (_totalQuestions > 0 ? _totalQuestions : 1);

    return {
      'accuracy': _correctAnswers / _totalQuestions,
      'average_score_per_question': _totalScore / _totalQuestions,
      'average_time_per_question': avgTimePerQuestion,
      'fastest_answer': _answers.isNotEmpty
          ? _answers.map((a) => a.timeTaken).reduce((a, b) => a < b ? a : b)
          : 0,
      'slowest_answer': _answers.isNotEmpty
          ? _answers.map((a) => a.timeTaken).reduce((a, b) => a > b ? a : b)
          : 0,
    };
  }

  /// Check if session is complete
  bool isSessionComplete() {
    return _currentQuestionIndex >= _totalQuestions;
  }

  /// Get remaining questions count
  int getRemainingQuestions() {
    return _totalQuestions - _currentQuestionIndex;
  }

  /// Get progress percentage
  double getProgressPercentage() {
    return (_currentQuestionIndex / _totalQuestions) * 100;
  }

  /// Get suspicious activities
  List<SuspiciousActivity> getSuspiciousActivities() {
    return _antiCheatService.suspiciousActivities;
  }
}
