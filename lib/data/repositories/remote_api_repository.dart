/// Remote API Repository - Cloudflare Worker Communication
/// مستودع API البعيد - التواصل مع Cloudflare Worker
library;

import 'package:b_brane/models/game_link_question.dart';
import 'package:b_brane/models/game_session.dart';

abstract class RemoteApiRepository {
  /// Authentication
  Future<String> register(String username, String email, String password);
  Future<String> login(String email, String password);
  Future<String> refreshToken(String refreshToken);

  /// Questions
  Future<List<GameLinkQuestion>> getQuestions({
    required int page,
    required int limit,
    String? gameMode,
    String? difficulty,
  });
  Future<GameLinkQuestion> getQuestion(String questionId);

  /// Game Sessions
  Future<void> submitGameSession(GameSession session);
  Future<GameSession?> getGameSession(String sessionId);

  /// Player Data
  Future<Map<String, dynamic>> getPlayerProfile();
  Future<void> updatePlayerProfile(Map<String, dynamic> profile);

  /// Leaderboard
  Future<List<Map<String, dynamic>>> getLeaderboard({
    required int page,
    required int limit,
  });

  /// Sync
  Future<void> syncOfflineData(List<Map<String, dynamic>> data);
}

/// Implementation (to be used with http/dio)
class RemoteApiRepositoryImpl implements RemoteApiRepository {
  final String baseUrl;
  String? authToken;

  RemoteApiRepositoryImpl({required this.baseUrl});

  @override
  Future<String> register(
    String username,
    String email,
    String password,
  ) async {
    // Implementation will use http.post()
    // POST /auth/register
    throw UnimplementedError();
  }

  @override
  Future<String> login(String email, String password) async {
    // Implementation will use http.post()
    // POST /auth/login
    throw UnimplementedError();
  }

  @override
  Future<String> refreshToken(String refreshToken) async {
    // Implementation will use http.post()
    // POST /auth/refresh-token
    throw UnimplementedError();
  }

  @override
  Future<List<GameLinkQuestion>> getQuestions({
    required int page,
    required int limit,
    String? gameMode,
    String? difficulty,
  }) async {
    // Implementation will use http.get()
    // GET /questions?page=X&limit=X
    throw UnimplementedError();
  }

  @override
  Future<GameLinkQuestion> getQuestion(String questionId) async {
    // Implementation will use http.get()
    // GET /questions/:id
    throw UnimplementedError();
  }

  @override
  Future<void> submitGameSession(GameSession session) async {
    // Implementation will use http.post()
    // POST /sessions/:id/complete
    throw UnimplementedError();
  }

  @override
  Future<GameSession?> getGameSession(String sessionId) async {
    // Implementation will use http.get()
    // GET /sessions/:id
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getPlayerProfile() async {
    // Implementation will use http.get()
    // GET /players/me
    throw UnimplementedError();
  }

  @override
  Future<void> updatePlayerProfile(Map<String, dynamic> profile) async {
    // Implementation will use http.patch()
    // PATCH /players/me
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getLeaderboard({
    required int page,
    required int limit,
  }) async {
    // Implementation will use http.get()
    // GET /players/leaderboard?page=X&limit=X
    throw UnimplementedError();
  }

  @override
  Future<void> syncOfflineData(List<Map<String, dynamic>> data) async {
    // Implementation will use http.post()
    // POST /sync/queue
    throw UnimplementedError();
  }
}
