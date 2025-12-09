import 'package:b_brane/models/game_question.dart';
import 'package:b_brane/data/database/database_provider.dart';

/// مستودع الأسئلة
class QuestionRepository {
  final DatabaseProvider _dbProvider = DatabaseProvider();

  /// الحصول على سؤال عشوائي
  Future<GameQuestion?> getRandomQuestion(String difficulty) async {
    final data = await _dbProvider.getRandomQuestion(difficulty);
    if (data == null) return null;
    
    return GameQuestion.fromJson(data);
  }

  /// حفظ سؤال
  Future<void> saveQuestion(GameQuestion question) async {
    await _dbProvider.insertQuestion(question.toJson());
  }

  /// حفظ عدة أسئلة
  Future<void> saveQuestions(List<GameQuestion> questions) async {
    for (final question in questions) {
      await saveQuestion(question);
    }
  }

  /// الحصول على عدد الأسئلة المحلية
  Future<int> getLocalQuestionCount() async {
    return await _dbProvider.getQuestionCount();
  }
}
