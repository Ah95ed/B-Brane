library;

enum QuestionType {
  twoWords, // ربط كلمتين
  twoImages, // ربط صورتين
  twoEmojis, // ربط رمزين
  twoEvents, // ربط حدثين
  chainLinks, // سلسلة روابط
}

enum DifficultyLevel { easy, medium, hard, legendary }

class GameQuestion {
  final String id;
  final QuestionType type;
  final DifficultyLevel difficulty;

  /// الخيار الأول (نص أو رمز أو صورة URL)
  final String item1;

  /// الخيار الثاني
  final String item2;

  /// الإجابة الصحيحة (الرابط المنطقي)
  final String correctLink;

  /// خيارات خاطئة لتشتيت اللاعب (3-5 خيارات)
  final List<String> distractors;

  /// للأسئلة من نوع السلسلة: قائمة الروابط المتسلسلة
  final List<String>? chainSequence;

  /// عدد الروابط المطلوبة في السلسلة
  final int chainLength;

  /// الفئة (اختياري): للإحصائيات والتحليلات
  final String? category;

  /// معرف الصورة للخيار الأول (إن وجدت)
  final String? image1Url;

  /// معرف الصورة للخيار الثاني
  final String? image2Url;

  /// وقت إنشاء السؤال
  final DateTime createdAt;

  /// آخر تحديث
  final DateTime updatedAt;

  /// عدد مرات اللعب
  final int playCount;

  /// عدد الإجابات الصحيحة
  final int correctAnswerCount;

  GameQuestion({
    required this.id,
    required this.type,
    required this.difficulty,
    required this.item1,
    required this.item2,
    required this.correctLink,
    required this.distractors,
    this.chainSequence,
    this.chainLength = 1,
    this.category,
    this.image1Url,
    this.image2Url,
    required this.createdAt,
    required this.updatedAt,
    this.playCount = 0,
    this.correctAnswerCount = 0,
  });

  factory GameQuestion.fromJson(Map<String, dynamic> json) {
    return GameQuestion(
      id: json['id'] as String,
      type: QuestionType.values[json['type'] as int? ?? 0],
      difficulty: DifficultyLevel.values[json['difficulty'] as int? ?? 0],
      item1: json['item1'] as String,
      item2: json['item2'] as String,
      correctLink: json['correctLink'] as String,
      distractors: List<String>.from(json['distractors'] as List),
      chainSequence: json['chainSequence'] != null
          ? List<String>.from(json['chainSequence'] as List)
          : null,
      chainLength: json['chainLength'] as int? ?? 1,
      category: json['category'] as String?,
      image1Url: json['image1Url'] as String?,
      image2Url: json['image2Url'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      playCount: json['playCount'] as int? ?? 0,
      correctAnswerCount: json['correctAnswerCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.index,
    'difficulty': difficulty.index,
    'item1': item1,
    'item2': item2,
    'correctLink': correctLink,
    'distractors': distractors,
    'chainSequence': chainSequence,
    'chainLength': chainLength,
    'category': category,
    'image1Url': image1Url,
    'image2Url': image2Url,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'playCount': playCount,
    'correctAnswerCount': correctAnswerCount,
  };

  /// حساب نسبة النجاح
  double get successRate =>
      playCount == 0 ? 0.0 : correctAnswerCount / playCount;

  /// الحصول على جميع الخيارات المخلوطة (الصحيح + الخاطئ)
  List<String> getAllOptions() {
    final options = [...distractors, correctLink];
    options.shuffle();
    return options;
  }

  /// إنشاء نسخة معدلة
  GameQuestion copyWith({
    String? id,
    QuestionType? type,
    DifficultyLevel? difficulty,
    String? item1,
    String? item2,
    String? correctLink,
    List<String>? distractors,
    List<String>? chainSequence,
    int? chainLength,
    String? category,
    String? image1Url,
    String? image2Url,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? playCount,
    int? correctAnswerCount,
  }) {
    return GameQuestion(
      id: id ?? this.id,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      item1: item1 ?? this.item1,
      item2: item2 ?? this.item2,
      correctLink: correctLink ?? this.correctLink,
      distractors: distractors ?? this.distractors,
      chainSequence: chainSequence ?? this.chainSequence,
      chainLength: chainLength ?? this.chainLength,
      category: category ?? this.category,
      image1Url: image1Url ?? this.image1Url,
      image2Url: image2Url ?? this.image2Url,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      playCount: playCount ?? this.playCount,
      correctAnswerCount: correctAnswerCount ?? this.correctAnswerCount,
    );
  }
}
