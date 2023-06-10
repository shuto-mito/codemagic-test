import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final db = await openDatabase('app.db',
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE test ('
        'id INTEGER NOT NULL PRIMARY KEY'
        ',count INTEGER NOT NULL'
        ')'
      );
    }
  );
  return db;
}

class DatabaseService {
  static Database? database;

  Future<Database> getDatabase() async {
    database ??= await openDatabase('app.db',
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE test ('
          'id INTEGER NOT NULL PRIMARY KEY'
          ',count INTEGER NOT NULL'
          ')'
        );
      }
    );
    return database!;
  }

  Future<void> setCount(int value) async {
    final db = await getDatabase();
    await db.update('test', {'id': 1, 'count': value});
  }

  Future<int> getCount() async {
    final db = await getDatabase();
    final results = await db.query('table', where: 'id = ?', whereArgs: [1]);
    if (results.isEmpty) return 0;
    return results.first['count'] as int;
  }
}
