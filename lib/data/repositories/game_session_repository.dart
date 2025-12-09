import 'package:b_brane/models/game_session.dart';
import 'package:b_brane/data/database/database_provider.dart';

/// مستودع جلسات اللعب
class GameSessionRepository {
  final DatabaseProvider _dbProvider = DatabaseProvider();

  /// إنشاء جلسة لعب جديدة
  Future<void> createSession(GameSession session) async {
    await _dbProvider.insertGameSession(session.toJson());
  }

  /// تحديث جلسة لعب
  Future<void> updateSession(GameSession session) async {
    await _dbProvider.updateGameSession(
      session.sessionId,
      session.toJson(),
    );
  }
}
