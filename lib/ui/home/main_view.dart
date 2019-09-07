import 'package:flutter/material.dart';
import 'package:food_list_by_brian/config.dart';
import '../food_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spin;
import '../../helper/request.dart';
import 'package:http/http.dart' as http;
class MainView extends StatelessWidget {
  final String category;

  @override
  MainView({this.category});

  Widget build(BuildContext context) {
    return showFoodWidget(category);
  }

  FutureBuilder showFoodWidget(String category) {
    RequestHelper request = RequestHelper();
    return FutureBuilder(
        future: request.getFoodData(category: category, http: http.Client()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
                key: Key('mainCard'),
                crossAxisCount: 2,
                children:
                getFoodMenu(listFood: snapshot.data, context: context));
          } else {
            return Center(
              child: spin.SpinKitFoldingCube(
                color: Config.primaryColor,
              ),
            );
          }
        });
  }

  List<Widget> getFoodMenu({List listFood, BuildContext context}) {
    int counter = 0;
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
              key: Key('foodCard${counter++}'),
              child: (data.thumbnail != null &&
                  data.thumbnail
                      .toString()
                      .isNotEmpty)
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
