import 'package:uuid/uuid.dart';

/// منطق حساب النقاط والتقييم
class ScoringEngine {
  /// النقاط الأساسية حسب مستوى الصعوبة
  static const Map<String, int> baseScores = {
    'easy': 10,
    'medium': 25,
    'hard': 50,
    'legendary': 100,
  };

  /// مضاعف النقاط حسب الوقت (كلما أسرع كلما أعلى)
  /// إذا أجاب في أقل من 3 ثوان: 1.5x
  /// بين 3-10 ثوان: 1.0x
  /// أكثر من 10 ثوان: 0.5x
  static double getTimeMultiplier(int secondsTaken) {
    if (secondsTaken <= 3) return 1.5;
    if (secondsTaken <= 10) return 1.0;
    return 0.5;
  }

  /// حساب النقاط النهائية
  static int calculateScore(
    String difficulty,
    int secondsTaken,
    int chainLength,
  ) {
    final baseScore = baseScores[difficulty] ?? 10;
    final timeMultiplier = getTimeMultiplier(secondsTaken);
    
    // مضاعف السلسلة: كل رابط إضافي = 1.1x
    final chainMultiplier = 1.0 + (chainLength - 1) * 0.1;
    
    return (baseScore * timeMultiplier * chainMultiplier).toInt();
  }

  /// تحديد الرمز (نجمة) حسب الأداء
  /// 1 نجمة: إجابة صحيحة
  /// 2 نجمة: إجابة صحيحة وسريعة (أقل من 5 ثوان)
  /// 3 نجمة: إجابة صحيحة جداً وسريعة جداً (أقل من 3 ثوان)
  static int getStars(int secondsTaken, bool isCorrect) {
    if (!isCorrect) return 0;
    if (secondsTaken <= 3) return 3;
    if (secondsTaken <= 5) return 2;
    return 1;
  }
}

/// محرك اللعبة الرئيسي
class GameEngine {
  final String playerId;
  final String difficulty;
  late String sessionId;
  late DateTime sessionStartTime;
  
  int currentScore = 0;
  int questionsAnswered = 0;
  int correctAnswers = 0;
  int currentChainLength = 0;
  final List<String> answeredQuestionIds = [];
  
  GameEngine({
    required this.playerId,
    required this.difficulty,
  }) {
    sessionId = const Uuid().v4();
    sessionStartTime = DateTime.now();
  }

  /// معالجة الإجابة
  GameEngineResult processAnswer({
    required String questionId,
    required String userAnswer,
    required String correctAnswer,
    required int secondsTaken,
    required int chainLength,
  }) {
    questionsAnswered++;
    final isCorrect = userAnswer.toLowerCase().trim() ==
        correctAnswer.toLowerCase().trim();

    if (isCorrect) {
      correctAnswers++;
      currentChainLength++;
      
      final score = ScoringEngine.calculateScore(
        difficulty,
        secondsTaken,
        chainLength,
      );
      currentScore += score;
      
      final stars = ScoringEngine.getStars(secondsTaken, isCorrect);
      
      answeredQuestionIds.add(questionId);
      
      return GameEngineResult(
        isCorrect: true,
        scoreGained: score,
        stars: stars,
        newChainLength: currentChainLength,
        totalScore: currentScore,
      );
    } else {
      currentChainLength = 0; // إعادة تعيين السلسلة عند الخطأ
      
      return GameEngineResult(
        isCorrect: false,
        scoreGained: 0,
        stars: 0,
        newChainLength: 0,
        totalScore: currentScore,
      );
    }
  }

  /// إنهاء الجلسة
  GameSessionResult endSession() {
    final endTime = DateTime.now();
    final durationSeconds = endTime.difference(sessionStartTime).inSeconds;
    
    return GameSessionResult(
      sessionId: sessionId,
      playerId: playerId,
      startedAt: sessionStartTime,
      endedAt: endTime,
      score: currentScore,
      questionsAnswered: questionsAnswered,
      correctAnswers: correctAnswers,
      durationSeconds: durationSeconds,
      successRate: questionsAnswered == 0
          ? 0.0
          : (correctAnswers / questionsAnswered) * 100,
      averageTimePerQuestion: questionsAnswered == 0
          ? 0.0
          : durationSeconds / questionsAnswered,
    );
  }

  /// حساب نسبة النجاح
  double get successRate =>
      questionsAnswered == 0 ? 0.0 : (correctAnswers / questionsAnswered);
}

/// نتيجة معالجة الإجابة
class GameEngineResult {
  final bool isCorrect;
  final int scoreGained;
  final int stars;
  final int newChainLength;
  final int totalScore;

  GameEngineResult({
    required this.isCorrect,
    required this.scoreGained,
    required this.stars,
    required this.newChainLength,
    required this.totalScore,
  });
}

/// نتيجة الجلسة النهائية
class GameSessionResult {
  final String sessionId;
  final String playerId;
  final DateTime startedAt;
  final DateTime endedAt;
  final int score;
  final int questionsAnswered;
  final int correctAnswers;
  final int durationSeconds;
  final double successRate;
  final double averageTimePerQuestion;

  GameSessionResult({
    required this.sessionId,
    required this.playerId,
    required this.startedAt,
    required this.endedAt,
    required this.score,
    required this.questionsAnswered,
    required this.correctAnswers,
    required this.durationSeconds,
    required this.successRate,
    required this.averageTimePerQuestion,
  });
}
