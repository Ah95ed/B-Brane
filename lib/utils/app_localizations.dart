/// App Localizations - English and Arabic strings
/// سلاسل التطبيق - الإنجليزية والعربية
library;

class AppLocalizations {
  static const Map<String, Map<String, String>> strings = {
    'en': {
      // App Name
      'app_name': 'Weird Link',
      'app_tagline': 'Find the Connection',

      // Navigation
      'home': 'Home',
      'play': 'Play',
      'profile': 'Profile',
      'leaderboard': 'Leaderboard',
      'settings': 'Settings',

      // Game Modes
      'mode_word_to_word': 'Word Link',
      'mode_image_to_image': 'Image Link',
      'mode_emoji_chain': 'Emoji Chain',
      'mode_event_to_event': 'Event Link',
      'mode_link_chain': 'Link Chain',

      // Difficulty
      'difficulty_easy': 'Easy',
      'difficulty_medium': 'Medium',
      'difficulty_expert': 'Expert',
      'difficulty_legendary': 'Legendary',

      // Game Screen
      'find_link': 'Find the Link',
      'select_answer': 'Select the correct answer',
      'time_remaining': 'Time Remaining',
      'score': 'Score',
      'question': 'Question',

      // Results
      'game_over': 'Game Over!',
      'final_score': 'Final Score',
      'correct_answers': 'Correct Answers',
      'accuracy': 'Accuracy',
      'time_played': 'Time Played',
      'play_again': 'Play Again',
      'back_to_home': 'Back to Home',

      // Profile
      'username': 'Username',
      'level': 'Level',
      'total_score': 'Total Score',
      'games_played': 'Games Played',
      'win_streak': 'Win Streak',
      'favorite_mode': 'Favorite Mode',

      // Messages
      'correct': 'Correct!',
      'wrong': 'Wrong!',
      'loading': 'Loading...',
      'error': 'Error',
      'try_again': 'Try Again',
      'offline': 'Offline Mode',
      'online': 'Online Mode',

      // Settings
      'language': 'Language',
      'sound_effects': 'Sound Effects',
      'vibration': 'Vibration',
      'notifications': 'Notifications',
      'about': 'About',
      'logout': 'Logout',

      // Achievements
      'achievement_perfect': 'Perfect Game',
      'achievement_fire': 'On Fire!',
      'achievement_legend': 'Legend Status',
    },
    'ar': {
      // App Name
      'app_name': 'الرابط العجيب',
      'app_tagline': 'أوجد الاتصال',

      // Navigation
      'home': 'الرئيسية',
      'play': 'العب',
      'profile': 'الملف الشخصي',
      'leaderboard': 'لوحة الصدارة',
      'settings': 'الإعدادات',

      // Game Modes
      'mode_word_to_word': 'ربط الكلمات',
      'mode_image_to_image': 'ربط الصور',
      'mode_emoji_chain': 'سلسلة الرموز',
      'mode_event_to_event': 'ربط الأحداث',
      'mode_link_chain': 'سلسلة الروابط',

      // Difficulty
      'difficulty_easy': 'سهل',
      'difficulty_medium': 'متوسط',
      'difficulty_expert': 'خبير',
      'difficulty_legendary': 'أسطوري',

      // Game Screen
      'find_link': 'أوجد الرابط',
      'select_answer': 'اختر الإجابة الصحيحة',
      'time_remaining': 'الوقت المتبقي',
      'score': 'النقاط',
      'question': 'السؤال',

      // Results
      'game_over': 'انتهت اللعبة!',
      'final_score': 'النقاط النهائية',
      'correct_answers': 'الإجابات الصحيحة',
      'accuracy': 'الدقة',
      'time_played': 'وقت اللعب',
      'play_again': 'العب مرة أخرى',
      'back_to_home': 'العودة للرئيسية',

      // Profile
      'username': 'اسم المستخدم',
      'level': 'المستوى',
      'total_score': 'إجمالي النقاط',
      'games_played': 'الألعاب المنتهية',
      'win_streak': 'سلسلة الانتصارات',
      'favorite_mode': 'أفضل نمط',

      // Messages
      'correct': 'صحيح!',
      'wrong': 'خطأ!',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'try_again': 'حاول مرة أخرى',
      'offline': 'وضع عدم الاتصال',
      'online': 'وضع الاتصال',

      // Settings
      'language': 'اللغة',
      'sound_effects': 'المؤثرات الصوتية',
      'vibration': 'الاهتزاز',
      'notifications': 'الإشعارات',
      'about': 'عن التطبيق',
      'logout': 'تسجيل الخروج',

      // Achievements
      'achievement_perfect': 'لعبة مثالية',
      'achievement_fire': 'نار ملتهبة!',
      'achievement_legend': 'حالة الأسطورة',
    },
  };

  /// Get string by key and language
  static String get(String key, {String language = 'en'}) {
    return strings[language]?[key] ?? strings['en']![key]!;
  }

  /// Get string with pluralization support
  static String plural(String key, int count, {String language = 'en'}) {
    final baseKey = key;
    final pluralKey = '$key${count == 1 ? '_singular' : '_plural'}';

    return strings[language]?[pluralKey] ??
        strings[language]?[baseKey] ??
        strings['en']![baseKey]!;
  }
}

/// Extension for easier access
extension StringLocalization on String {
  String tr({String language = 'en'}) {
    return AppLocalizations.get(this, language: language);
  }
}
