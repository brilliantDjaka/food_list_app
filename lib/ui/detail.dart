import 'dart:convert';
import 'package:flutter/material.dart';
import './food_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spin;
import 'package:http/http.dart' as http;
class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}
class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    final FoodModel data = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: getFood(data.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Center(
                      child: Hero(
                        child: Image.network(snapshot.data['strMealThumb']),
                        tag: data.id,
                      ),
                    ),
                    Text('Ingredients : \n\n'
                        '${snapshot.data['strInstructions']}\n\n\n'
                        'video tutorial :\n'
                        '\n'),
                    GestureDetector(
                        child: Text('${snapshot.data['strYoutube']}',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () {
                          _launchURL(snapshot.data['strYoutube']);
                        })
                  ],
                );
              }
              else {
                return spin.SpinKitWave(
                  color: Colors.blueAccent,
                );
              }
            },
          )
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<Map> getFood(id) async{
    http.Response data = await http.get('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id');
    Map result = json.decode(data.body);
    result = result['meals'][0];
    return result;
  }
}
