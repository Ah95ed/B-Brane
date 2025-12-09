/// Local Database Repository
/// مستودع قاعدة البيانات المحلي
library;

import 'package:b_brane/models/game_link_question.dart';
import 'package:b_brane/models/game_session.dart';
import 'package:b_brane/models/game_answer.dart';
import 'package:b_brane/models/player_stats.dart';

abstract class LocalDatabaseRepository {
  /// Initialize database
  Future<void> initialize();

  /// Questions
  Future<GameLinkQuestion?> getQuestion(String questionId);
  Future<List<GameLinkQuestion>> getQuestions({
    required int limit,
    required int offset,
    String? gameMode,
    String? difficulty,
  });
  Future<int> getTotalQuestionsCount();
  Future<void> saveQuestions(List<GameLinkQuestion> questions);

  /// Game Sessions
  Future<String> createGameSession(GameSession session);
  Future<GameSession?> getGameSession(String sessionId);
  Future<List<GameSession>> getPlayerSessions(String playerId);
  Future<void> updateGameSession(GameSession session);
  Future<void> deleteGameSession(String sessionId);

  /// Game Answers
  Future<void> saveGameAnswer(GameAnswer answer);
  Future<List<GameAnswer>> getSessionAnswers(String sessionId);
  Future<void> deleteSessionAnswers(String sessionId);

  /// Player Statistics
  Future<PlayerStats?> getPlayerStats(String playerId);
  Future<void> updatePlayerStats(PlayerStats stats);
  Future<void> createPlayerStats(PlayerStats stats);

  /// Sync Queue (for offline-first)
  Future<void> addToSyncQueue({
    required String entityType,
    required String entityId,
    required String action,
    required Map<String, dynamic> data,
  });
  Future<List<Map<String, dynamic>>> getSyncQueue();
  Future<void> clearSyncQueue(List<String> queueIds);

  /// Cleanup
  Future<void> close();
}

/// Implementation using SQLite/Hive (to be implemented)
class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  @override
  Future<void> initialize() async {
    // To be implemented with SQLite or Hive
    throw UnimplementedError();
  }

  @override
  Future<GameLinkQuestion?> getQuestion(String questionId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<GameLinkQuestion>> getQuestions({
    required int limit,
    required int offset,
    String? gameMode,
    String? difficulty,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<int> getTotalQuestionsCount() async {
    throw UnimplementedError();
  }

  @override
  Future<void> saveQuestions(List<GameLinkQuestion> questions) async {
    throw UnimplementedError();
  }

  @override
  Future<String> createGameSession(GameSession session) async {
    throw UnimplementedError();
  }

  @override
  Future<GameSession?> getGameSession(String sessionId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<GameSession>> getPlayerSessions(String playerId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateGameSession(GameSession session) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteGameSession(String sessionId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> saveGameAnswer(GameAnswer answer) async {
    throw UnimplementedError();
  }

  @override
  Future<List<GameAnswer>> getSessionAnswers(String sessionId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSessionAnswers(String sessionId) async {
    throw UnimplementedError();
  }

  @override
  Future<PlayerStats?> getPlayerStats(String playerId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePlayerStats(PlayerStats stats) async {
    throw UnimplementedError();
  }

  @override
  Future<void> createPlayerStats(PlayerStats stats) async {
    throw UnimplementedError();
  }

  @override
  Future<void> addToSyncQueue({
    required String entityType,
    required String entityId,
    required String action,
    required Map<String, dynamic> data,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getSyncQueue() async {
    throw UnimplementedError();
  }

  @override
  Future<void> clearSyncQueue(List<String> queueIds) async {
    throw UnimplementedError();
  }

  @override
  Future<void> close() async {
    throw UnimplementedError();
  }
}
