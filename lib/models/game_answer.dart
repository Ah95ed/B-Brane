/// Game Answer Model - tracks player answers
/// نموذج إجابة اللاعب
library;

import 'package:uuid/uuid.dart';

class GameAnswer {
  /// Unique identifier
  final String id;

  /// Session ID this answer belongs to
  final String sessionId;

  /// Question ID
  final String questionId;

  /// Player's selected answer (Arabic)
  final String selectedAnswerAr;

  /// Player's selected answer (English)
  final String selectedAnswerEn;

  /// Correct answer (Arabic)
  final String correctAnswerAr;

  /// Correct answer (English)
  final String correctAnswerEn;

  /// Whether the answer is correct
  final bool isCorrect;

  /// Time taken to answer (in seconds)
  final int timeTaken;

  /// Points earned for this answer
  final int pointsEarned;

  /// Timestamp
  final DateTime answeredAt;

  GameAnswer({
    String? id,
    required this.sessionId,
    required this.questionId,
    required this.selectedAnswerAr,
    required this.selectedAnswerEn,
    required this.correctAnswerAr,
    required this.correctAnswerEn,
    required this.isCorrect,
    required this.timeTaken,
    required this.pointsEarned,
    DateTime? answeredAt,
  }) : id = id ?? const Uuid().v4(),
       answeredAt = answeredAt ?? DateTime.now();

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'session_id': sessionId,
    'question_id': questionId,
    'selected_answer_ar': selectedAnswerAr,
    'selected_answer_en': selectedAnswerEn,
    'correct_answer_ar': correctAnswerAr,
    'correct_answer_en': correctAnswerEn,
    'is_correct': isCorrect ? 1 : 0,
    'time_taken': timeTaken,
    'points_earned': pointsEarned,
    'answered_at': answeredAt.toIso8601String(),
  };

  /// Create from JSON
  factory GameAnswer.fromJson(Map<String, dynamic> json) => GameAnswer(
    id: json['id'] as String,
    sessionId: json['session_id'] as String,
    questionId: json['question_id'] as String,
    selectedAnswerAr: json['selected_answer_ar'] as String,
    selectedAnswerEn: json['selected_answer_en'] as String,
    correctAnswerAr: json['correct_answer_ar'] as String,
    correctAnswerEn: json['correct_answer_en'] as String,
    isCorrect: (json['is_correct'] as int) == 1,
    timeTaken: json['time_taken'] as int,
    pointsEarned: json['points_earned'] as int,
    answeredAt: DateTime.parse(json['answered_at'] as String),
  );

  /// Copy with modifications
  GameAnswer copyWith({
    String? id,
    String? sessionId,
    String? questionId,
    String? selectedAnswerAr,
    String? selectedAnswerEn,
    String? correctAnswerAr,
    String? correctAnswerEn,
    bool? isCorrect,
    int? timeTaken,
    int? pointsEarned,
    DateTime? answeredAt,
  }) => GameAnswer(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    questionId: questionId ?? this.questionId,
    selectedAnswerAr: selectedAnswerAr ?? this.selectedAnswerAr,
    selectedAnswerEn: selectedAnswerEn ?? this.selectedAnswerEn,
    correctAnswerAr: correctAnswerAr ?? this.correctAnswerAr,
    correctAnswerEn: correctAnswerEn ?? this.correctAnswerEn,
    isCorrect: isCorrect ?? this.isCorrect,
    timeTaken: timeTaken ?? this.timeTaken,
    pointsEarned: pointsEarned ?? this.pointsEarned,
    answeredAt: answeredAt ?? this.answeredAt,
  );

  @override
  String toString() =>
      'GameAnswer($id, correct: $isCorrect, points: $pointsEarned)';
}
