import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spin;
import 'package:flutter/material.dart';
import './food_model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomBarCurrent = 0;

  @override
  Widget build(BuildContext context) {
    List content = [showFoodWidget('Dessert'), showFoodWidget('Seafood')];
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Lisuto'),
        centerTitle: true,
      ),
      body: content[bottomBarCurrent],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text('Dessert'), icon: Icon(Icons.fastfood)),
          BottomNavigationBarItem(
              title: Text('Seafood'), icon: Icon(Icons.cake))
        ],
        currentIndex: bottomBarCurrent,
        onTap: (int selected) {
          setState(() {
            bottomBarCurrent = selected;
          });
        },
      ),
    );
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
              child: spin.SpinKitWave(
                 color: Colors.blueAccent,
              ),
            );
          }
        });
  }

  Future<List> getFoodData({String category}) async {
      var response = await http.get('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category', headers: {
        'X-RapidAPI-Host': 'recipe-puppy.p.rapidapi.com',
        'X-RapidAPI-Key': '1e564e6c10msh7e12cb56442b016p1e7006jsna9fcf54df7ef'
      });
      Map tempData = await json.decode(response.body);
      if(response.statusCode != 200){
        return [];
      }
      List result = tempData['meals'].map((e)=>FoodModel(foodMap: e)).toList();
    return result;
  }

  List<Widget> getFoodMenu({List listFood, BuildContext context}) {
    List data = listFood.map((e) {
      FoodModel data = e;
      return Card(
        borderOnForeground: true,
        child: Center(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/detail',
                  arguments: e);
            },
            title: Hero(
              child: (data.thumbnail != null && data.thumbnail.toString().isNotEmpty)
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
