import 'package:flutter/material.dart';
import '../food_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spin;
import '../../helper/request.dart';

class MainView extends StatelessWidget {
  final String category;

  @override
  MainView({this.category});

  Widget build(BuildContext context) {
    return showFoodWidget(category);
  }

  FutureBuilder showFoodWidget(String category) {
    return FutureBuilder(
        future: getFoodData(category: category),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
                crossAxisCount: 2,
                children:
                    getFoodMenu(listFood: snapshot.data, context: context));
          } else {
            return Center(
              child: spin.SpinKitFoldingCube(
                color: Colors.blueAccent,
              ),
            );
          }
        });
  }

  List<Widget> getFoodMenu({List listFood, BuildContext context}) {
    List data = listFood.map((e) {
      FoodModel data = e;
      return Card(
        borderOnForeground: true,
        child: Center(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: e);
            },
            title: Hero(
              child: (data.thumbnail != null &&
                      data.thumbnail.toString().isNotEmpty)
                  ? Image.network(
                      data.thumbnail,
                      fit: BoxFit.contain,
                      height: 90,
                      width: 90,
                    )
                  : Image.asset(
                      'images/noimageavailable.png',
                      fit: BoxFit.contain,
                      height: 90,
                      width: 90,
                    ),
              tag: data.id,
            ),
            subtitle: Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      );
    }).toList();
    return data;
  }
}
