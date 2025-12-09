/// Game Link Question Model
/// نموذج سؤال الربط في اللعبة
library;

import 'difficulty.dart';
import 'game_mode.dart';

class GameLinkQuestion {
  /// Unique identifier for the question
  final String id;

  /// Game mode (1-5)
  final GameMode mode;

  /// First item in the pair (Arabic text)
  final String itemATextAr;

  /// First item in the pair (English text)
  final String itemATextEn;

  /// First item image URL (optional)
  final String? itemAImageUrl;

  /// First item emoji (optional)
  final String? itemAEmoji;

  /// Second item in the pair (Arabic text)
  final String itemBTextAr;

  /// Second item in the pair (English text)
  final String itemBTextEn;

  /// Second item image URL (optional)
  final String? itemBImageUrl;

  /// Second item emoji (optional)
  final String? itemBEmoji;

  /// Correct link answer (Arabic)
  final String correctLinkAr;

  /// Correct link answer (English)
  final String correctLinkEn;

  /// Difficulty level
  final Difficulty difficulty;

  /// Category (history, science, culture, etc.)
  final String? category;

  /// Wrong answer options (for multiple choice)
  final List<String> wrongOptionsAr;
  final List<String> wrongOptionsEn;

  /// Whether this question is part of a chain
  final bool isChainQuestion;

  /// Position in chain (if applicable)
  final int? chainPosition;

  /// Content hash for anti-cheating
  final String? contentHash;

  GameLinkQuestion({
    required this.id,
    required this.mode,
    required this.itemATextAr,
    required this.itemATextEn,
    required this.itemBTextAr,
    required this.itemBTextEn,
    required this.correctLinkAr,
    required this.correctLinkEn,
    required this.difficulty,
    this.itemAImageUrl,
    this.itemAEmoji,
    this.itemBImageUrl,
    this.itemBEmoji,
    this.category,
    this.wrongOptionsAr = const [],
    this.wrongOptionsEn = const [],
    this.isChainQuestion = false,
    this.chainPosition,
    this.contentHash,
  });

  /// Get item A text based on language
  String getItemAText(String language) {
    return language == 'ar' ? itemATextAr : itemATextEn;
  }

  /// Get item B text based on language
  String getItemBText(String language) {
    return language == 'ar' ? itemBTextAr : itemBTextEn;
  }

  /// Get correct link based on language
  String getCorrectLink(String language) {
    return language == 'ar' ? correctLinkAr : correctLinkEn;
  }

  /// Get wrong options based on language
  List<String> getWrongOptions(String language) {
    return language == 'ar' ? wrongOptionsAr : wrongOptionsEn;
  }

  /// Get all options (shuffled)
  List<String> getAllOptions(String language) {
    final options = [getCorrectLink(language), ...getWrongOptions(language)];
    options.shuffle();
    return options;
  }

  /// Generate content hash for anti-cheating
  String generateContentHash() {
    final content = '$itemATextAr$itemBTextAr$correctLinkAr';
    // Simple hash (in production, use a proper hashing algorithm)
    return content.hashCode.toString();
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'mode': mode.getModeNumber(),
    'item_a_text_ar': itemATextAr,
    'item_a_text_en': itemATextEn,
    'item_a_image_url': itemAImageUrl,
    'item_a_emoji': itemAEmoji,
    'item_b_text_ar': itemBTextAr,
    'item_b_text_en': itemBTextEn,
    'item_b_image_url': itemBImageUrl,
    'item_b_emoji': itemBEmoji,
    'correct_link_ar': correctLinkAr,
    'correct_link_en': correctLinkEn,
    'difficulty': difficulty.toStorageString(),
    'category': category,
    'wrong_options_ar': wrongOptionsAr,
    'wrong_options_en': wrongOptionsEn,
    'is_chain_question': isChainQuestion,
    'chain_position': chainPosition,
    'content_hash': contentHash,
  };

  /// Create from JSON
  factory GameLinkQuestion.fromJson(Map<String, dynamic> json) =>
      GameLinkQuestion(
        id: json['id'] as String,
        mode: GameModeHelper.fromStorageString(json['mode'].toString()),
        itemATextAr: json['item_a_text_ar'] as String,
        itemATextEn: json['item_a_text_en'] as String,
        itemAImageUrl: json['item_a_image_url'] as String?,
        itemAEmoji: json['item_a_emoji'] as String?,
        itemBTextAr: json['item_b_text_ar'] as String,
        itemBTextEn: json['item_b_text_en'] as String,
        itemBImageUrl: json['item_b_image_url'] as String?,
        itemBEmoji: json['item_b_emoji'] as String?,
        correctLinkAr: json['correct_link_ar'] as String,
        correctLinkEn: json['correct_link_en'] as String,
        difficulty: DifficultyHelper.fromStorageString(
          json['difficulty'] as String,
        ),
        category: json['category'] as String?,
        wrongOptionsAr: List<String>.from(json['wrong_options_ar'] as List),
        wrongOptionsEn: List<String>.from(json['wrong_options_en'] as List),
        isChainQuestion: json['is_chain_question'] as bool? ?? false,
        chainPosition: json['chain_position'] as int?,
        contentHash: json['content_hash'] as String?,
      );

  @override
  String toString() => 'GameLinkQuestion($id, ${mode.getEnglishName()})';
}
