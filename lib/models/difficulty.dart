/// Game Difficulty Levels
/// مستويات صعوبة اللعبة
library;

enum Difficulty {
  easy, // سهل - 🟢
  medium, // متوسط - 🟡
  expert, // خبير - 🔴
  legendary, // أسطوري - ⚫
}

extension DifficultyExtension on Difficulty {
  /// Get Arabic name
  String getArabicName() {
    switch (this) {
      case Difficulty.easy:
        return 'سهل';
      case Difficulty.medium:
        return 'متوسط';
      case Difficulty.expert:
        return 'خبير';
      case Difficulty.legendary:
        return 'أسطوري';
    }
  }

  /// Get English name
  String getEnglishName() {
    switch (this) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.expert:
        return 'Expert';
      case Difficulty.legendary:
        return 'Legendary';
    }
  }

  /// Get name based on language
  String getName(String language) {
    return language == 'ar' ? getArabicName() : getEnglishName();
  }

  /// Get difficulty score multiplier
  double getScoreMultiplier() {
    switch (this) {
      case Difficulty.easy:
        return 1.0;
      case Difficulty.medium:
        return 1.5;
      case Difficulty.expert:
        return 2.0;
      case Difficulty.legendary:
        return 3.0;
    }
  }

  /// Get timer duration in seconds
  int getTimerDuration(int questionType) {
    switch (this) {
      case Difficulty.easy:
        return 15;
      case Difficulty.medium:
        return 12;
      case Difficulty.expert:
        return 10;
      case Difficulty.legendary:
        return 8;
    }
  }

  /// Get number of wrong options
  int getWrongOptionsCount() {
    switch (this) {
      case Difficulty.easy:
        return 2;
      case Difficulty.medium:
        return 4;
      case Difficulty.expert:
        return 5;
      case Difficulty.legendary:
        return 6;
    }
  }

  /// Convert to string for storage
  String toStorageString() {
    switch (this) {
      case Difficulty.easy:
        return 'easy';
      case Difficulty.medium:
        return 'medium';
      case Difficulty.expert:
        return 'expert';
      case Difficulty.legendary:
        return 'legendary';
    }
  }
}

/// Static helper for Difficulty enum
class DifficultyHelper {
  /// Create from string
  static Difficulty fromStorageString(String value) {
    switch (value) {
      case 'easy':
        return Difficulty.easy;
      case 'medium':
        return Difficulty.medium;
      case 'expert':
        return Difficulty.expert;
      case 'legendary':
        return Difficulty.legendary;
      default:
        return Difficulty.medium;
    }
  }
}
