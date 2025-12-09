import 'package:b_brane/models/player_stats.dart';
import 'package:b_brane/data/database/database_provider.dart';

/// مستودع إحصائيات اللاعب
class PlayerStatsRepository {
  final DatabaseProvider _dbProvider = DatabaseProvider();

  /// حفظ أو تحديث إحصائيات لاعب
  Future<void> savePlayerStats(PlayerStats stats) async {
    await _dbProvider.upsertPlayerStats(stats.toJson());
  }

  /// الحصول على إحصائيات لاعب
  Future<PlayerStats?> getPlayerStats(String playerId) async {
    final data = await _dbProvider.getPlayerStats(playerId);
    if (data == null) return null;
    
    return PlayerStats.fromJson(data);
  }
}
