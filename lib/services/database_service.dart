import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService db = DatabaseService();

  Database? _database;

  Future<Database?> getDatabase() async {
    if (_database != null) return _database;

    _database = await createDb();

    return _database;
  }
}

Future<Database> createDb() async {
  String dbPath = await getDatabasesPath();

  print(dbPath);
  return await openDatabase(
    join(dbPath, 'user.db'),
    version: 1,
    onCreate: (Database database, int version) async {
      final String query =
          'CREATE TABLE users(id INTEGER PRIMARY KEY, email TEXT, password TEXT, first_name TEXT, last_name TEXT, username TEXT)';
      await database.execute(query);
    },
  );
}
