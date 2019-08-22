import 'package:food_list_by_brian/ui/food_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

insertToFavorite(FoodModel foodModel) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'food.db');
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute('CREATE TABLE favorite ('
        'id TEXT PRIMARY KEY,'
        'title TEXT,'
        'thumbnail TEXT'
        ')');
  });
  await database.insert('favorite', foodModel.toMap());
}

deleteFromFavorite(FoodModel foodModel) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'food.db');
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute('CREATE TABLE favorite ('
        'id TEXT PRIMARY KEY,'
        'title TEXT,'
        'thumbnail TEXT'
        ')');
  });
  await database.delete('favorite', where: 'id = ${foodModel.id}');
}
