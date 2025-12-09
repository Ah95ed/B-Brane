/// Game State Management using Provider (ChangeNotifier)
/// مزود حالة اللعبة باستخدام Provider (ChangeNotifier)
library;

import 'package:flutter/foundation.dart';
import 'package:b_brane/logic/game/game_logic.dart';
import 'package:b_brane/models/game_link_question.dart';
import 'package:b_brane/models/difficulty.dart';
import 'package:b_brane/models/game_mode.dart';

class GameProvider extends ChangeNotifier {
  final GameLogic _gameLogic = GameLogic();
  bool _isLoading = false;
  String? _error;

  // Getters that UI can bind to via Provider
  GameLinkQuestion? get currentQuestion => _gameLogic.currentQuestion;
  int get currentQuestionIndex => _gameLogic.currentQuestionIndex;
  int get totalQuestions => _gameLogic.totalQuestions;
  int get correctAnswers => _gameLogic.correctAnswers;
  int get totalScore => _gameLogic.totalScore;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Initialize new game session
  Future<void> initializeSession({
    required String sessionId,
    required List<GameLinkQuestion> questions,
    required GameMode gameMode,
    required Difficulty difficulty,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _gameLogic.initializeSession(
        sessionId: sessionId,
        questions: questions,
        gameMode: gameMode,
        difficulty: difficulty,
      );
      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Submit answer
  Future<void> submitAnswer({
    required String selectedAnswerAr,
    required String selectedAnswerEn,
    required int timeTaken,
  }) async {
    try {
      final answer = _gameLogic.submitAnswer(
        selectedAnswerAr: selectedAnswerAr,
        selectedAnswerEn: selectedAnswerEn,
        timeTaken: timeTaken,
      );

      if (answer != null) {
        _error = null;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Move to next question
  Future<void> nextQuestion() async {
    if (_gameLogic.nextQuestion()) {
      notifyListeners();
    }
  }

  /// Complete session
  Future<Map<String, dynamic>> completeSession() async {
    final result = _gameLogic.completeSession();
    notifyListeners();
    return result;
  }

  /// Get game statistics
  Map<String, dynamic> getGameStatistics() {
    return _gameLogic.getGameStatistics();
  }

  /// Reset game
  void reset() {
    // Clear transient state; full GameLogic reset requires recreating provider
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}
