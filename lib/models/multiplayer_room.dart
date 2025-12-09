/// Multiplayer Room Model - for future real-time multiplayer
/// نموذج غرفة اللعب المتعدد اللاعبين - للعب المتزامن في المستقبل
library;

import 'package:uuid/uuid.dart';

class MultiplayerRoom {
  /// Unique room identifier
  final String id;

  /// Room name
  final String nameAr;
  final String nameEn;

  /// Room host/creator ID
  final String hostId;

  /// Current players in room
  final List<RoomPlayer> players;

  /// Maximum players allowed
  final int maxPlayers;

  /// Game mode for this room
  final int gameMode;

  /// Difficulty level
  final String difficulty;

  /// Room status
  RoomStatus status;

  /// Created timestamp
  final DateTime createdAt;

  /// Game start timestamp
  DateTime? startedAt;

  /// Game end timestamp
  DateTime? endedAt;

  MultiplayerRoom({
    String? id,
    required this.nameAr,
    required this.nameEn,
    required this.hostId,
    List<RoomPlayer>? players,
    this.maxPlayers = 4,
    required this.gameMode,
    required this.difficulty,
    this.status = RoomStatus.waiting,
    DateTime? createdAt,
  }) : id = id ?? const Uuid().v4(),
       players = players ?? [],
       createdAt = createdAt ?? DateTime.now();

  /// Get room name by language
  String getName(String language) {
    return language == 'ar' ? nameAr : nameEn;
  }

  /// Add player to room
  bool addPlayer(RoomPlayer player) {
    if (players.length < maxPlayers && !players.any((p) => p.id == player.id)) {
      players.add(player);
      return true;
    }
    return false;
  }

  /// Remove player from room
  bool removePlayer(String playerId) {
    final initialLength = players.length;
    players.removeWhere((p) => p.id == playerId);
    return players.length < initialLength;
  }

  /// Check if room is full
  bool isFull() => players.length >= maxPlayers;

  /// Check if room can start
  bool canStart() => players.length >= 2 && status == RoomStatus.waiting;

  /// Start game
  void startGame() {
    if (canStart()) {
      status = RoomStatus.playing;
      startedAt = DateTime.now();
    }
  }

  /// End game
  void endGame() {
    status = RoomStatus.finished;
    endedAt = DateTime.now();
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name_ar': nameAr,
    'name_en': nameEn,
    'host_id': hostId,
    'players': players.map((p) => p.toJson()).toList(),
    'max_players': maxPlayers,
    'game_mode': gameMode,
    'difficulty': difficulty,
    'status': status.toString().split('.').last,
    'created_at': createdAt.toIso8601String(),
    'started_at': startedAt?.toIso8601String(),
    'ended_at': endedAt?.toIso8601String(),
  };

  /// Create from JSON
  factory MultiplayerRoom.fromJson(Map<String, dynamic> json) =>
      MultiplayerRoom(
        id: json['id'] as String,
        nameAr: json['name_ar'] as String,
        nameEn: json['name_en'] as String,
        hostId: json['host_id'] as String,
        players: (json['players'] as List)
            .map((p) => RoomPlayer.fromJson(p as Map<String, dynamic>))
            .toList(),
        maxPlayers: json['max_players'] as int,
        gameMode: json['game_mode'] as int,
        difficulty: json['difficulty'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
      );
}

/// Player in multiplayer room
class RoomPlayer {
  /// Player ID
  final String id;

  /// Player username
  final String username;

  /// Player avatar URL
  final String? avatarUrl;

  /// Current score in this room
  int score = 0;

  /// Number of correct answers
  int correctAnswers = 0;

  /// Status in room
  PlayerRoomStatus status;

  /// Join timestamp
  final DateTime joinedAt;

  RoomPlayer({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.status = PlayerRoomStatus.waiting,
    DateTime? joinedAt,
  }) : joinedAt = joinedAt ?? DateTime.now();

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'avatar_url': avatarUrl,
    'score': score,
    'correct_answers': correctAnswers,
    'status': status.toString().split('.').last,
    'joined_at': joinedAt.toIso8601String(),
  };

  /// Create from JSON
  factory RoomPlayer.fromJson(Map<String, dynamic> json) => RoomPlayer(
    id: json['id'] as String,
    username: json['username'] as String,
    avatarUrl: json['avatar_url'] as String?,
    joinedAt: DateTime.parse(json['joined_at'] as String),
  );
}

/// Room Status
enum RoomStatus {
  waiting, // Waiting for players
  playing, // Game in progress
  finished, // Game completed
  cancelled, // Room cancelled
}

/// Player Status in Room
enum PlayerRoomStatus {
  waiting, // Waiting to start
  playing, // Currently playing
  finished, // Completed game
  disconnected, // Disconnected from room
}
