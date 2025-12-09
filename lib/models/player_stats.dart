library;

class PlayerStats {
  final String playerId;
  final String playerName;
  final int totalScore;
  final int gamesPlayed;
  final int correctAnswers;
  final int wrongAnswers;
  final double averageTime;

  /// أعلى نقاط في جلسة واحدة
  final int highestScore;

  /// أطول سلسلة روابط متواصلة
  final int longestChain;

  /// آخر جلسة لعب
  final DateTime? lastPlayedAt;

  /// الترتيب العالمي (للمستقبل)
  final int? globalRank;

  /// عدد النجوم المجمعة (achievements)
  final int starsCollected;

  PlayerStats({
    required this.playerId,
    required this.playerName,
    required this.totalScore,
    required this.gamesPlayed,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.averageTime,
    required this.highestScore,
    required this.longestChain,
    this.lastPlayedAt,
    this.globalRank,
    required this.starsCollected,
  });

  factory PlayerStats.fromJson(Map<String, dynamic> json) {
    return PlayerStats(
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      totalScore: json['totalScore'] as int? ?? 0,
      gamesPlayed: json['gamesPlayed'] as int? ?? 0,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      wrongAnswers: json['wrongAnswers'] as int? ?? 0,
      averageTime: (json['averageTime'] as num? ?? 0).toDouble(),
      highestScore: json['highestScore'] as int? ?? 0,
      longestChain: json['longestChain'] as int? ?? 0,
      lastPlayedAt: json['lastPlayedAt'] != null
          ? DateTime.parse(json['lastPlayedAt'] as String)
          : null,
      globalRank: json['globalRank'] as int?,
      starsCollected: json['starsCollected'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'playerId': playerId,
    'playerName': playerName,
    'totalScore': totalScore,
    'gamesPlayed': gamesPlayed,
    'correctAnswers': correctAnswers,
    'wrongAnswers': wrongAnswers,
    'averageTime': averageTime,
    'highestScore': highestScore,
    'longestChain': longestChain,
    'lastPlayedAt': lastPlayedAt?.toIso8601String(),
    'globalRank': globalRank,
    'starsCollected': starsCollected,
  };

  /// حساب نسبة النجاح
  double get successRate {
    final total = correctAnswers + wrongAnswers;
    return total == 0 ? 0.0 : (correctAnswers / total) * 100;
  }

  /// حساب المستوى بناءً على النقاط
  int get level {
    return (totalScore / 1000).toInt() + 1;
  }

  PlayerStats copyWith({
    String? playerId,
    String? playerName,
    int? totalScore,
    int? gamesPlayed,
    int? correctAnswers,
    int? wrongAnswers,
    double? averageTime,
    int? highestScore,
    int? longestChain,
    DateTime? lastPlayedAt,
    int? globalRank,
    int? starsCollected,
  }) {
    return PlayerStats(
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      totalScore: totalScore ?? this.totalScore,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      averageTime: averageTime ?? this.averageTime,
      highestScore: highestScore ?? this.highestScore,
      longestChain: longestChain ?? this.longestChain,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
      globalRank: globalRank ?? this.globalRank,
      starsCollected: starsCollected ?? this.starsCollected,
    );
  }
}
