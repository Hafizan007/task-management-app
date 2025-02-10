import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../constants/db_constant.dart';

@singleton
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), DbConstant.dbName);
    return await openDatabase(
      path,
      version: DbConstant.dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DbConstant.taskTable} (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        dueDate TEXT NOT NULL,
        taskStatus TEXT NOT NULL DEFAULT 'pending',
        createdAt DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DbConstant.syncQueueTable} (
        id TEXT PRIMARY KEY,
        operation TEXT NOT NULL,
        data TEXT NOT NULL,
        created_at DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}
