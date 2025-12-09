library;

class GameSession {
  final String sessionId;
  final String playerId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int score;
  final int questionsAnswered;
  final int correctAnswers;

  /// مدة الجلسة بالثواني
  final int? durationSeconds;

  /// أنماط الأسئلة في الجلسة
  final List<String> questionTypes;

  /// مستويات الصعوبة
  final List<String> difficulties;

  /// الفئات
  final List<String>? categories;

  GameSession({
    required this.sessionId,
    required this.playerId,
    required this.startedAt,
    this.endedAt,
    required this.score,
    required this.questionsAnswered,
    required this.correctAnswers,
    this.durationSeconds,
    required this.questionTypes,
    required this.difficulties,
    this.categories,
  });

  factory GameSession.fromJson(Map<String, dynamic> json) {
    return GameSession(
      sessionId: json['sessionId'] as String,
      playerId: json['playerId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] != null
          ? DateTime.parse(json['endedAt'] as String)
          : null,
      score: json['score'] as int? ?? 0,
      questionsAnswered: json['questionsAnswered'] as int? ?? 0,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      durationSeconds: json['durationSeconds'] as int?,
      questionTypes: List<String>.from(json['questionTypes'] as List),
      difficulties: List<String>.from(json['difficulties'] as List),
      categories: json['categories'] != null
          ? List<String>.from(json['categories'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'playerId': playerId,
    'startedAt': startedAt.toIso8601String(),
    'endedAt': endedAt?.toIso8601String(),
    'score': score,
    'questionsAnswered': questionsAnswered,
    'correctAnswers': correctAnswers,
    'durationSeconds': durationSeconds,
    'questionTypes': questionTypes,
    'difficulties': difficulties,
    'categories': categories,
  };

  /// هل الجلسة نشطة الآن
  bool get isActive => endedAt == null;

  /// حساب نسبة النجاح
  double get successRate {
    return questionsAnswered == 0
        ? 0.0
        : (correctAnswers / questionsAnswered) * 100;
  }

  GameSession copyWith({
    String? sessionId,
    String? playerId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? score,
    int? questionsAnswered,
    int? correctAnswers,
    int? durationSeconds,
    List<String>? questionTypes,
    List<String>? difficulties,
    List<String>? categories,
  }) {
    return GameSession(
      sessionId: sessionId ?? this.sessionId,
      playerId: playerId ?? this.playerId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      score: score ?? this.score,
      questionsAnswered: questionsAnswered ?? this.questionsAnswered,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      questionTypes: questionTypes ?? this.questionTypes,
      difficulties: difficulties ?? this.difficulties,
      categories: categories ?? this.categories,
    );
  }
}
