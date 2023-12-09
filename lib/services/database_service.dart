import 'package:mod7_lista_tarefas/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

const String createTable = '''
  CREATE TABLE IF NOT EXISTS ${Constants.dbTableName}(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT,
    status INTEGER
  )
''';

class DatabaseService {
  Database? db;

  Future<Database> getDb() async => db ?? await _startDB();

  Future<Database> _startDB() async {
    final db = openDatabase(
      path.join(await getDatabasesPath(), 'todo_database.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(createTable);
      },
    );
    return db;
  }
}
