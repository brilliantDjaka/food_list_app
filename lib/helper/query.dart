import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<bool> checkData(String id) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'food.db');
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute('CREATE TABLE favorite (id TEXT PRIMARY KEY)');
  });
  List list = await database.rawQuery('select * from favorite where id = $id');
  if (list.length == 0) {
    return false;
  } else {
    return true;
  }
}
