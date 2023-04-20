import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "UserDatabase.db";
  static const _databaseVersion = 1;
  static const _table = "users";

  static const columnEmail = "email";
  static const columnUsername = "username";

  // Singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_table (
        $columnEmail TEXT PRIMARY KEY,
        $columnUsername TEXT NOT NULL
      )
      ''');
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    await db.insert(_table, user);
  }

  Future<String> getUsername(String email) async {
    final db = await instance.database;
    final result = await db.query(_table,
        columns: [columnUsername],
        where: "$columnEmail = ?",
        whereArgs: [email]);
    if (result.isNotEmpty) {
      return result.first[columnUsername];
    }
    return null;
  }
}
