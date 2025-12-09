/// Link Item Model - represents one item in a link pair
/// يمثل عنصر واحد في زوج روابط
library;

class LinkItem {
  /// Unique identifier
  final String id;

  /// Item text in Arabic
  final String textAr;

  /// Item text in English
  final String textEn;

  /// Optional image URL
  final String? imageUrl;

  /// Optional emoji representation
  final String? emoji;

  /// Item category (for filtering)
  final String? category;

  /// Difficulty level (1-4)
  final int difficultyLevel;

  LinkItem({
    required this.id,
    required this.textAr,
    required this.textEn,
    this.imageUrl,
    this.emoji,
    this.category,
    this.difficultyLevel = 1,
  });

  /// Get text based on language
  String getText(String language) {
    return language == 'ar' ? textAr : textEn;
  }

  /// Convert to JSON (for API/Database)
  Map<String, dynamic> toJson() => {
    'id': id,
    'text_ar': textAr,
    'text_en': textEn,
    'image_url': imageUrl,
    'emoji': emoji,
    'category': category,
    'difficulty_level': difficultyLevel,
  };

  /// Create from JSON
  factory LinkItem.fromJson(Map<String, dynamic> json) => LinkItem(
    id: json['id'] as String,
    textAr: json['text_ar'] as String,
    textEn: json['text_en'] as String,
    imageUrl: json['image_url'] as String?,
    emoji: json['emoji'] as String?,
    category: json['category'] as String?,
    difficultyLevel: json['difficulty_level'] as int? ?? 1,
  );

  /// Create a copy with modifications
  LinkItem copyWith({
    String? id,
    String? textAr,
    String? textEn,
    String? imageUrl,
    String? emoji,
    String? category,
    int? difficultyLevel,
  }) => LinkItem(
    id: id ?? this.id,
    textAr: textAr ?? this.textAr,
    textEn: textEn ?? this.textEn,
    imageUrl: imageUrl ?? this.imageUrl,
    emoji: emoji ?? this.emoji,
    category: category ?? this.category,
    difficultyLevel: difficultyLevel ?? this.difficultyLevel,
  );

  @override
  String toString() => 'LinkItem($id, $textAr, $textEn)';
}
