/// توليد الأسئلة والخيارات
class QuestionGenerator {
  /// قاعدة أسئلة النمط الأول: ربط كلمتين
  static final List<Map<String, dynamic>> twoWordsQuestions = [
    {
      'item1': '🔥 نار',
      'item2': '💨 دخان',
      'correctLink': 'حريق',
      'distractors': ['طهي', 'حرارة', 'غاز', 'تدفئة'],
      'category': 'طبيعة',
    },
    {
      'item1': '⚕️ طبيب',
      'item2': '💊 دواء',
      'correctLink': 'معالجة',
      'distractors': ['مرض', 'صحة', 'علاج', 'مستشفى'],
      'category': 'طب',
    },
    {
      'item1': '📚 كتاب',
      'item2': '✏️ قلم',
      'correctLink': 'كتابة',
      'distractors': ['قراءة', 'تعليم', 'ورقة', 'مكتبة'],
      'category': 'تعليم',
    },
  ];

  /// قاعدة أسئلة النمط الثاني: ربط صورتين
  static final List<Map<String, dynamic>> twoImagesQuestions = [
    {
      'item1': '🍎 تفاحة',
      'item2': '👨‍⚕️ طبيب',
      'correctLink': 'صحة',
      'distractors': ['فاكهة', 'مهنة', 'طعام', 'علم'],
      'category': 'صحة',
    },
    {
      'item1': '⚽ كرة قدم',
      'item2': '🏟️ ملعب',
      'correctLink': 'رياضة',
      'distractors': ['لعبة', 'مكان', 'فريق', 'منافسة'],
      'category': 'رياضة',
    },
  ];

  /// قاعدة أسئلة النمط الثالث: ربط رمزين
  static final List<Map<String, dynamic>> twoEmojisQuestions = [
    {
      'item1': '⚽',
      'item2': '🧦',
      'correctLink': 'رياضة',
      'distractors': ['لاعب', 'ملابس', 'لعبة', 'تجهيزات'],
      'category': 'رياضة',
    },
    {
      'item1': '🍕',
      'item2': '👨‍🍳',
      'correctLink': 'طهي',
      'distractors': ['طعام', 'مهنة', 'مطبخ', 'طاهي'],
      'category': 'طعام',
    },
  ];

  /// قاعدة أسئلة النمط الرابع: ربط حدثين
  static final List<Map<String, dynamic>> twoEventsQuestions = [
    {
      'item1': 'اكتشاف النار 🔥',
      'item2': 'اختراع العجلة 🛞',
      'correctLink': 'بداية الحضارة',
      'distractors': ['تطور', 'اختراع', 'تاريخ', 'إنسان'],
      'category': 'تاريخ',
    },
  ];

  /// قاعدة أسئلة النمط الخامس: سلسلة روابط
  static final List<Map<String, dynamic>> chainQuestionsQuestions = [
    {
      'chainSequence': ['نار', 'دخان', 'إطفاء', 'مطافي'],
      'correctLink': 'نار',
      'chainLength': 4,
      'category': 'سلاسل',
    },
  ];

  /// الحصول على أسئلة عشوائية
  static Map<String, dynamic> getRandomTwoWordsQuestion() {
    return _getRandomFromList(twoWordsQuestions);
  }

  static Map<String, dynamic> getRandomTwoImagesQuestion() {
    return _getRandomFromList(twoImagesQuestions);
  }

  static Map<String, dynamic> getRandomTwoEmojisQuestion() {
    return _getRandomFromList(twoEmojisQuestions);
  }

  static Map<String, dynamic> getRandomTwoEventsQuestion() {
    return _getRandomFromList(twoEventsQuestions);
  }

  static Map<String, dynamic> getRandomChainQuestion() {
    return _getRandomFromList(chainQuestionsQuestions);
  }

  static Map<String, dynamic> _getRandomFromList(
    List<Map<String, dynamic>> list,
  ) {
    list.shuffle();
    return list.first;
  }
}
