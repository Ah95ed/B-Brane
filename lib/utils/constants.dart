/// App Constants File
/// ملف مشترك للثوابت والإعدادات
library;

class Constants {
  /// App Basic Info
  static const String appName = 'الرابط العجيب';
  static const String appNameEn = 'Weird Link';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  /// Supported Languages
  static const List<String> supportedLanguages = ['ar', 'en'];
  static const String defaultLanguage = 'en';

  /// Timer Durations (in seconds)
  static const int easyTimer = 15;
  static const int mediumTimer = 12;
  static const int expertTimer = 10;
  static const int legendaryTimer = 8;

  /// Game Configuration
  static const int defaultQuestionsPerSession = 10;
  static const int maxQuestionsPerSession = 50;
  static const int minQuestionsPerSession = 1;
  static const int minLocalQuestions = 1000;

  /// Database
  static const String dbName = 'weird_link.db';
  static const int dbVersion = 1;

  /// API Configuration
  static const String apiBaseUrl = 'https://api.weirdlink.com/v1';
  static const String cloudflareWorkerUrl = 'https://weirdlink.workers.dev';
  static const String websocketUrl = 'wss://weirdlink.workers.dev/ws';
  static const int apiTimeout = 30;

  /// Scoring
  static const int baseScore = 100;
  static const int maxTimeBonus = 50;

  /// UI Configuration
  static const int animationDuration = 300;
  static const int transitionDuration = 500;

  /// Cache Configuration
  static const int sessionCacheDuration = 3600;
  static const int leaderboardCacheDuration = 1800;

  /// Anti-Cheat
  static const int minReasonableAnswerTime = 2;
  static const int maxSessionScoreIncrease = 10000;

  /// Feature Flags
  static const bool multiplayerEnabled = false;
  static const bool socialSharingEnabled = true;
  static const bool offlineFirstEnabled = true;

  /// Storage Keys
  static const String storageKeyPlayerId = 'player_id';
  static const String storageKeyLanguage = 'language';
  static const String storageKeyAuthToken = 'auth_token';
  static const String storageKeyLastSync = 'last_sync';

  /// Validation
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 20;
  static const int minPasswordLength = 6;
}

/// Game Rules Configuration
class GameRules {
  static int getTimerDuration(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return Constants.easyTimer;
      case 'medium':
        return Constants.mediumTimer;
      case 'expert':
        return Constants.expertTimer;
      case 'legendary':
        return Constants.legendaryTimer;
      default:
        return Constants.mediumTimer;
    }
  }

  static double getDifficultyMultiplier(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return 1.0;
      case 'medium':
        return 1.5;
      case 'expert':
        return 2.0;
      case 'legendary':
        return 3.0;
      default:
        return 1.0;
    }
  }

  static int getWrongOptionsCount(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return 2;
      case 'medium':
        return 4;
      case 'expert':
        return 5;
      case 'legendary':
        return 6;
      default:
        return 3;
    }
  }
}



