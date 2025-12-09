import 'package:b_brane/data/repositories/question_repository.dart';
import 'package:b_brane/data/repositories/game_session_repository.dart';
import 'package:b_brane/data/repositories/player_stats_repository.dart';

/// خدمة تطبيق اللعبة الرئيسية
class GameService {
  final QuestionRepository questionRepository;
  final GameSessionRepository gameSessionRepository;
  final PlayerStatsRepository playerStatsRepository;

  GameService({
    required this.questionRepository,
    required this.gameSessionRepository,
    required this.playerStatsRepository,
  });

  /// اختبار الاتصال
  Future<bool> isOnline() async {
    // سيتم استخدام هذا لاحقاً للتحقق من الاتصال بالإنترنت
    // أو الاتصال بـ Cloudflare Worker
    return true;
  }

  /// التحقق من عدد الأسئلة المحلية
  Future<bool> hasEnoughLocalQuestions() async {
    final count = await questionRepository.getLocalQuestionCount();
    return count >= 1000; // الحد الأدنى المطلوب
  }
}
