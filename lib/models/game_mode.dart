/// Game Mode Types
/// أنواع أنماط اللعبة
library;

enum GameMode {
  wordToWord, // Mode 1: ربط كلمتين
  imageToImage, // Mode 2: ربط صورتين
  emojiChain, // Mode 3: ربط رموز
  eventToEvent, // Mode 4: ربط حدثين
  linkChain, // Mode 5: سلسلة روابط
}

extension GameModeExtension on GameMode {
  /// Get mode number (1-5)
  int getModeNumber() {
    switch (this) {
      case GameMode.wordToWord:
        return 1;
      case GameMode.imageToImage:
        return 2;
      case GameMode.emojiChain:
        return 3;
      case GameMode.eventToEvent:
        return 4;
      case GameMode.linkChain:
        return 5;
    }
  }

  /// Get Arabic name
  String getArabicName() {
    switch (this) {
      case GameMode.wordToWord:
        return 'ربط الكلمات';
      case GameMode.imageToImage:
        return 'ربط الصور';
      case GameMode.emojiChain:
        return 'ربط الرموز';
      case GameMode.eventToEvent:
        return 'ربط الأحداث';
      case GameMode.linkChain:
        return 'سلسلة الروابط';
    }
  }

  /// Get English name
  String getEnglishName() {
    switch (this) {
      case GameMode.wordToWord:
        return 'Word Link';
      case GameMode.imageToImage:
        return 'Image Link';
      case GameMode.emojiChain:
        return 'Emoji Chain';
      case GameMode.eventToEvent:
        return 'Event Link';
      case GameMode.linkChain:
        return 'Link Chain';
    }
  }

  /// Get name based on language
  String getName(String language) {
    return language == 'ar' ? getArabicName() : getEnglishName();
  }

  /// Get mode description
  String getDescription(String language) {
    if (language == 'ar') {
      switch (this) {
        case GameMode.wordToWord:
          return 'اربط بين كلمتين مختلفتين بإيجاد الرابط المنطقي';
        case GameMode.imageToImage:
          return 'اربط بين صورتين بإيجاد ما يجمعهما';
        case GameMode.emojiChain:
          return 'اربط بين رموز بدون نصوص';
        case GameMode.eventToEvent:
          return 'اربط بين حدثين تاريخيين أو واقعيين';
        case GameMode.linkChain:
          return 'اتبع سلسلة من الروابط المتتالية';
      }
    } else {
      switch (this) {
        case GameMode.wordToWord:
          return 'Find the logical link between two different words';
        case GameMode.imageToImage:
          return 'Connect two images by finding their common link';
        case GameMode.emojiChain:
          return 'Link between symbols without text';
        case GameMode.eventToEvent:
          return 'Connect historical or real-world events';
        case GameMode.linkChain:
          return 'Follow a sequence of consecutive links';
      }
    }
  }

  /// Convert to string for storage
  String toStorageString() {
    switch (this) {
      case GameMode.wordToWord:
        return 'wordToWord';
      case GameMode.imageToImage:
        return 'imageToImage';
      case GameMode.emojiChain:
        return 'emojiChain';
      case GameMode.eventToEvent:
        return 'eventToEvent';
      case GameMode.linkChain:
        return 'linkChain';
    }
  }
}

/// Static helper for GameMode enum
class GameModeHelper {
  /// Create from string
  static GameMode fromStorageString(String value) {
    switch (value) {
      case 'wordToWord':
        return GameMode.wordToWord;
      case 'imageToImage':
        return GameMode.imageToImage;
      case 'emojiChain':
        return GameMode.emojiChain;
      case 'eventToEvent':
        return GameMode.eventToEvent;
      case 'linkChain':
        return GameMode.linkChain;
      default:
        return GameMode.wordToWord;
    }
  }
}
