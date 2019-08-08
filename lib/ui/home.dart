import 'dart:convert';

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
    List content = [showFoodWidget('breakfast'), showFoodWidget('dessert')];
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Lisuto'),
        centerTitle: true,
      ),
      body: content[bottomBarCurrent],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text('Breakfast'), icon: Icon(Icons.fastfood)),
          BottomNavigationBarItem(
              title: Text('Dessert'), icon: Icon(Icons.cake))
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
            return Card(
              child: Text('Loading'),
              borderOnForeground: true,
            );
          }
        });
  }

  Future<List> getFoodData({String category}) async {
    List data = [];
    int count = 1;
    String getUrl({int p, String q}) {
      return 'https://recipe-puppy.p.rapidapi.com/?p=$p&q=$q';
    }

    while (data.length < 20) {
      var response = await http.get(getUrl(p: count, q: category), headers: {
        'X-RapidAPI-Host': 'recipe-puppy.p.rapidapi.com',
        'X-RapidAPI-Key': '1e564e6c10msh7e12cb56442b016p1e7006jsna9fcf54df7ef'
      });
      Map tempData = await json.decode(response.body);
      List tempListFood = tempData['results'];
      tempListFood = tempListFood.where((e)=>(e['thumbnail'] != null && e['thumbnail'].toString().isNotEmpty)).toList();
      data.addAll(tempListFood);
      count++;
    }
    return data;
  }

  List<Widget> getFoodMenu({List listFood, BuildContext context}) {
    List data = listFood.map((e) {
      return Card(
        borderOnForeground: true,
        child: Center(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/detail',
                  arguments: FoodModel(foodMap: e));
            },
            title: Hero(
              child: (e['thumbnail'] != null && e['thumbnail'].toString().isNotEmpty)
                  ? Image.network(
                e['thumbnail'],
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
              tag: e['title'],
            ),
            subtitle: Text(
              e['title'],
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
