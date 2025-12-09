/// Scoring Engine - calculates points based on various factors
/// محرك النقاط - يحسب النقاط على أساس عوامل مختلفة
library;

import 'package:b_brane/models/difficulty.dart';
import 'package:b_brane/models/game_mode.dart';

class ScoringEngine {
  /// Base score for correct answer
  static const int baseScore = 100;

  /// Maximum time bonus (when answered instantly)
  static const int maxTimeBonus = 50;

  /// Minimum time for full bonus (in seconds)
  static const int minTimeForBonus = 5;

  /// Calculate points for a correct answer
  /// حساب النقاط للإجابة الصحيحة
  static int calculatePoints({
    required bool isCorrect,
    required Difficulty difficulty,
    required GameMode mode,
    required int timeTaken,
    required int timerDuration,
  }) {
    if (!isCorrect) {
      return 0;
    }

    // Base score
    int points = baseScore;

    // Apply difficulty multiplier
    points = (points * difficulty.getScoreMultiplier()).toInt();

    // Apply time bonus (faster = more points)
    int timeBonus = _calculateTimeBonus(timeTaken, timerDuration);
    points += timeBonus;

    // Mode-specific multipliers
    points = _applyModeMultiplier(points, mode);

    return points;
  }

  /// Calculate time bonus based on speed
  static int _calculateTimeBonus(int timeTaken, int timerDuration) {
    // If answered in less than half the time, get bonus
    if (timeTaken <= timerDuration / 2) {
      return maxTimeBonus;
    }

    // Linear scale from max bonus to 0
    final timeRatio = timeTaken / timerDuration;
    final bonus = (maxTimeBonus * (1 - timeRatio)).toInt();

    return bonus > 0 ? bonus : 0;
  }

  /// Apply mode-specific multipliers
  static int _applyModeMultiplier(int points, GameMode mode) {
    switch (mode) {
      case GameMode.wordToWord:
        return points; // 1.0x multiplier

      case GameMode.imageToImage:
        return (points * 1.1).toInt(); // 1.1x for visual processing

      case GameMode.emojiChain:
        return (points * 1.2).toInt(); // 1.2x for abstract thinking

      case GameMode.eventToEvent:
        return (points * 1.15).toInt(); // 1.15x for historical knowledge

      case GameMode.linkChain:
        return (points * 1.5).toInt(); // 1.5x for complex sequences
    }
  }

  /// Calculate streak bonus
  /// حساب مكافأة التسلسل الناجح
  static int calculateStreakBonus(int currentStreak) {
    if (currentStreak < 3) return 0;

    // Bonus increases with streak
    // 3-5: 10 points
    // 6-10: 25 points
    // 11-20: 50 points
    // 20+: 100 points
    if (currentStreak >= 20) return 100;
    if (currentStreak >= 11) return 50;
    if (currentStreak >= 6) return 25;
    return 10;
  }

  /// Calculate session score
  static int calculateSessionScore(List<int> questionScores) {
    return questionScores.fold(0, (sum, score) => sum + score);
  }

  /// Calculate average performance
  static double calculateAverageScore(List<int> scores) {
    if (scores.isEmpty) return 0.0;
    final sum = scores.fold(0, (sum, score) => sum + score);
    return sum / scores.length;
  }

  /// Calculate experience points (XP) for level progression
  static int calculateXP({
    required int sessionScore,
    required Difficulty difficulty,
    required int questionCount,
  }) {
    // Base XP = session score / 10
    int xp = (sessionScore / 10).toInt();

    // Difficulty bonus
    xp = (xp * difficulty.getScoreMultiplier()).toInt();

    // Question count bonus
    if (questionCount >= 10) {
      xp = (xp * 1.25).toInt();
    }

    return xp;
  }

  /// Get achievement unlocks
  static List<String> checkAchievements(
    int sessionScore,
    int correctAnswers,
    int totalQuestions,
    int currentStreak,
  ) {
    final achievements = <String>[];

    // Perfect score
    if (sessionScore > 5000) {
      achievements.add('legendary_score');
    }

    // Perfect game
    if (correctAnswers == totalQuestions) {
      achievements.add('perfect_game');
    }

    // Fire streak
    if (currentStreak >= 10) {
      achievements.add('on_fire');
    }

    return achievements;
  }
}
