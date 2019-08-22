import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import './main_view.dart';
import 'package:path/path.dart';
import '../food_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spin;

class FavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainView mainView = MainView();
    return FutureBuilder(
        future: _getFoodFromDb(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == false) {
              return Center(
                child: ListTile(
                  title: Icon(
                    Icons.warning,
                    color: Colors.blue,
                    size: 100,
                  ),
                  subtitle: Text(
                    'No Data',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
              );
            }
            return GridView.count(
                crossAxisCount: 2,
                children: mainView.getFoodMenu(
                    listFood: snapshot.data, context: context));
          } else {
            return Center(
              child: spin.SpinKitFoldingCube(
                color: Colors.blueAccent,
              ),
            );
          }
        });
  }

  Future _getFoodFromDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'food.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE favorite (id TEXT PRIMARY KEY)');
    });
    List list = await database.rawQuery('select * from favorite');
    print(list);
    if (list.length == 0) {
      return false;
    }
    List<FoodModel> result =
        list.map((e) => FoodModel.fromFoodModelMap(e)).toList();

    return result;
  }
}
