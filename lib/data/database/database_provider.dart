import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// إدارة قاعدة البيانات المحلية
class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  static Database? _database;

  factory DatabaseProvider() {
    return _instance;
  }

  DatabaseProvider._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'alrabet_aljibea.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // جدول الأسئلة
    await db.execute('''
      CREATE TABLE questions (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        difficulty TEXT NOT NULL,
        item1 TEXT NOT NULL,
        item2 TEXT NOT NULL,
        correct_link TEXT NOT NULL,
        distractors TEXT NOT NULL,
        chain_sequence TEXT,
        chain_length INTEGER DEFAULT 1,
        category TEXT,
        image1_url TEXT,
        image2_url TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        play_count INTEGER DEFAULT 0,
        correct_answer_count INTEGER DEFAULT 0
      )
    ''');

    // جدول إحصائيات اللاعب
    await db.execute('''
      CREATE TABLE player_stats (
        player_id TEXT PRIMARY KEY,
        player_name TEXT NOT NULL,
        total_score INTEGER DEFAULT 0,
        games_played INTEGER DEFAULT 0,
        correct_answers INTEGER DEFAULT 0,
        wrong_answers INTEGER DEFAULT 0,
        average_time REAL DEFAULT 0.0,
        highest_score INTEGER DEFAULT 0,
        longest_chain INTEGER DEFAULT 0,
        last_played_at INTEGER,
        global_rank INTEGER,
        stars_collected INTEGER DEFAULT 0
      )
    ''');

    // جدول جلسات اللعب
    await db.execute('''
      CREATE TABLE game_sessions (
        session_id TEXT PRIMARY KEY,
        player_id TEXT NOT NULL,
        started_at INTEGER NOT NULL,
        ended_at INTEGER,
        score INTEGER DEFAULT 0,
        questions_answered INTEGER DEFAULT 0,
        correct_answers INTEGER DEFAULT 0,
        duration_seconds INTEGER,
        question_types TEXT NOT NULL,
        difficulties TEXT NOT NULL,
        categories TEXT,
        FOREIGN KEY(player_id) REFERENCES player_stats(player_id)
      )
    ''');

    // جدول الإجابات للتحليل
    await db.execute('''
      CREATE TABLE answers_log (
        id TEXT PRIMARY KEY,
        session_id TEXT NOT NULL,
        question_id TEXT NOT NULL,
        user_answer TEXT NOT NULL,
        is_correct INTEGER NOT NULL,
        time_taken_seconds INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL,
        FOREIGN KEY(session_id) REFERENCES game_sessions(session_id),
        FOREIGN KEY(question_id) REFERENCES questions(id)
      )
    ''');

    // جدول التحديات اليومية
    await db.execute('''
      CREATE TABLE daily_challenges (
        id TEXT PRIMARY KEY,
        challenge_date TEXT NOT NULL UNIQUE,
        difficulty TEXT NOT NULL,
        description TEXT,
        target_score INTEGER,
        reward_stars INTEGER,
        created_at INTEGER NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // سيتم التعامل مع الترقيات المستقبلية هنا
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }

  // ===== عمليات الأسئلة =====

  /// إدراج سؤال جديد
  Future<void> insertQuestion(Map<String, dynamic> question) async {
    final db = await database;
    await db.insert(
      'questions',
      question,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// الحصول على سؤال عشوائي حسب مستوى الصعوبة
  Future<Map<String, dynamic>?> getRandomQuestion(String difficulty) async {
    final db = await database;
    final result = await db.query(
      'questions',
      where: 'difficulty = ?',
      whereArgs: [difficulty],
      orderBy: 'RANDOM()',
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  /// الحصول على عدد الأسئلة
  Future<int> getQuestionCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM questions');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ===== عمليات إحصائيات اللاعب =====

  /// إنشاء أو تحديث إحصائيات اللاعب
  Future<void> upsertPlayerStats(Map<String, dynamic> stats) async {
    final db = await database;
    await db.insert(
      'player_stats',
      stats,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// الحصول على إحصائيات لاعب
  Future<Map<String, dynamic>?> getPlayerStats(String playerId) async {
    final db = await database;
    final result = await db.query(
      'player_stats',
      where: 'player_id = ?',
      whereArgs: [playerId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ===== عمليات جلسات اللعب =====

  /// إنشاء جلسة لعب جديدة
  Future<void> insertGameSession(Map<String, dynamic> session) async {
    final db = await database;
    await db.insert('game_sessions', session);
  }

  /// تحديث جلسة لعب
  Future<void> updateGameSession(
    String sessionId,
    Map<String, dynamic> updates,
  ) async {
    final db = await database;
    await db.update(
      'game_sessions',
      updates,
      where: 'session_id = ?',
      whereArgs: [sessionId],
    );
  }

  // ===== عمليات سجل الإجابات =====

  /// تسجيل إجابة
  Future<void> insertAnswer(Map<String, dynamic> answer) async {
    final db = await database;
    await db.insert('answers_log', answer);
  }

  /// الحصول على إجابات جلسة معينة
  Future<List<Map<String, dynamic>>> getSessionAnswers(
    String sessionId,
  ) async {
    final db = await database;
    return await db.query(
      'answers_log',
      where: 'session_id = ?',
      whereArgs: [sessionId],
    );
  }
}
