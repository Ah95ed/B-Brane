/// Anti-Cheat Service - Prevents cheating and ensures fair gameplay
/// خدمة مكافحة الغش - تمنع الغش وتضمن اللعب النزيه
library;

import 'package:crypto/crypto.dart';
import 'dart:convert';

class AntiCheatService {
  /// Minimum reasonable time to answer (in seconds)
  static const int minReasonableTime = 2;

  /// Maximum score increase in one session
  static const int maxSessionScoreIncrease = 10000;

  /// Track suspicious activities
  final List<SuspiciousActivity> suspiciousActivities = [];

  /// Player session state (for runtime detection)
  final Map<String, PlayerSessionState> playerSessions = {};

  /// Initialize session tracking
  void initializeSession(String playerId, String sessionId) {
    playerSessions[playerId] = PlayerSessionState(
      sessionId: sessionId,
      startTime: DateTime.now(),
    );
  }

  /// Check if answer is suspicious
  SuspiciousActivityLevel checkAnswer({
    required String playerId,
    required String questionId,
    required int timeTaken,
    required int timerDuration,
    required bool isCorrect,
    required String selectedAnswer,
    required String correctAnswer,
  }) {
    final state = playerSessions[playerId];
    if (state == null) return SuspiciousActivityLevel.none;

    // Check 1: Impossible speed (too fast to read)
    if (timeTaken < minReasonableTime) {
      _recordActivity(
        playerId: playerId,
        severity: SuspiciousActivityLevel.high,
        reason: 'Answer submitted too quickly (${timeTaken}s)',
        questionId: questionId,
      );
      return SuspiciousActivityLevel.high;
    }

    // Check 2: Pattern detection (always perfect)
    if (isCorrect && state.consecutiveCorrect > 15) {
      if (timeTaken < 5) {
        _recordActivity(
          playerId: playerId,
          severity: SuspiciousActivityLevel.medium,
          reason: 'Suspicious pattern: Perfect streak with fast answers',
          questionId: questionId,
        );
        return SuspiciousActivityLevel.medium;
      }
    }

    // Check 3: Answer similarity (copy-paste detection)
    if (_hasUnusualSimilarity(selectedAnswer, correctAnswer)) {
      _recordActivity(
        playerId: playerId,
        severity: SuspiciousActivityLevel.medium,
        reason: 'Unusual answer similarity pattern',
        questionId: questionId,
      );
      return SuspiciousActivityLevel.medium;
    }

    // Check 4: Session score anomaly
    if (state.sessionScore > maxSessionScoreIncrease) {
      _recordActivity(
        playerId: playerId,
        severity: SuspiciousActivityLevel.critical,
        reason: 'Session score exceeds maximum realistic increase',
        questionId: questionId,
      );
      return SuspiciousActivityLevel.critical;
    }

    // Check 5: Multiple rapid sessions
    if (state.sessionsInPast24Hours > 20) {
      _recordActivity(
        playerId: playerId,
        severity: SuspiciousActivityLevel.medium,
        reason: 'Excessive number of sessions in 24 hours',
        questionId: questionId,
      );
      return SuspiciousActivityLevel.medium;
    }

    // Update state
    if (isCorrect) {
      state.consecutiveCorrect++;
    } else {
      state.consecutiveCorrect = 0;
    }
    state.sessionScore += 100; // Approximate

    return SuspiciousActivityLevel.none;
  }

  /// Check for unusual similarity between strings
  static bool _hasUnusualSimilarity(String str1, String str2) {
    // Remove common characters
    final cleaned1 = str1.toLowerCase().replaceAll(RegExp(r'\s'), '');
    final cleaned2 = str2.toLowerCase().replaceAll(RegExp(r'\s'), '');

    // Calculate similarity
    final similarity = _levenshteinSimilarity(cleaned1, cleaned2);

    // If more than 80% similar, it's suspicious
    return similarity > 0.8;
  }

  /// Calculate Levenshtein distance-based similarity
  static double _levenshteinSimilarity(String s1, String s2) {
    final maxLen = [s1.length, s2.length].reduce((a, b) => a > b ? a : b);
    if (maxLen == 0) return 1.0;

    final distance = _levenshteinDistance(s1, s2);
    return 1.0 - (distance / maxLen);
  }

  /// Calculate Levenshtein distance
  static int _levenshteinDistance(String s1, String s2) {
    final dp = List<List<int>>.generate(
      s1.length + 1,
      (i) => List<int>.filled(s2.length + 1, 0),
    );

    for (int i = 0; i <= s1.length; i++) {
      dp[i][0] = i;
    }
    for (int j = 0; j <= s2.length; j++) {
      dp[0][j] = j;
    }

    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1,
          dp[i][j - 1] + 1,
          dp[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return dp[s1.length][s2.length];
  }

  /// Record suspicious activity
  void _recordActivity({
    required String playerId,
    required SuspiciousActivityLevel severity,
    required String reason,
    required String questionId,
  }) {
    suspiciousActivities.add(
      SuspiciousActivity(
        playerId: playerId,
        severity: severity,
        reason: reason,
        questionId: questionId,
        timestamp: DateTime.now(),
      ),
    );
  }

  /// Generate content verification hash
  static String generateContentHash(
    String itemA,
    String itemB,
    String correctAnswer,
  ) {
    final content = '$itemA|$itemB|$correctAnswer';
    return sha256.convert(utf8.encode(content)).toString();
  }

  /// Verify content hasn't been tampered
  static bool verifyContentHash(
    String itemA,
    String itemB,
    String correctAnswer,
    String providedHash,
  ) {
    final calculatedHash = generateContentHash(itemA, itemB, correctAnswer);
    return calculatedHash == providedHash;
  }

  /// Clear session on completion
  void clearSession(String playerId) {
    playerSessions.remove(playerId);
  }
}

/// Suspicious Activity Level
enum SuspiciousActivityLevel { none, low, medium, high, critical }

/// Represents a suspicious activity
class SuspiciousActivity {
  final String playerId;
  final SuspiciousActivityLevel severity;
  final String reason;
  final String questionId;
  final DateTime timestamp;

  SuspiciousActivity({
    required this.playerId,
    required this.severity,
    required this.reason,
    required this.questionId,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'player_id': playerId,
    'severity': severity.toString().split('.').last,
    'reason': reason,
    'question_id': questionId,
    'timestamp': timestamp.toIso8601String(),
  };
}

/// Track player session state for runtime detection
class PlayerSessionState {
  final String sessionId;
  final DateTime startTime;
  int consecutiveCorrect = 0;
  int sessionScore = 0;
  int sessionsInPast24Hours = 1;

  PlayerSessionState({required this.sessionId, required this.startTime});
}
