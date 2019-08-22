import 'package:flutter/material.dart';
import 'package:food_list_by_brian/helper/query.dart';
import './food_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spin;
import '../helper/request.dart';
import '../helper/command.dart';
import 'package:toast/toast.dart';

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
                          launchURL(snapshot.data['strYoutube']);
                        }),
                    FutureBuilder(
                      future: checkData(data.id),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          print('error');
                          return RaisedButton(
                            color: Colors.white12,
                            child: Text(
                              'Error',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          );
                        }
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          if (snapshot.data == false) {
                            return RaisedButton(
                              color: Colors.blueAccent,
                              child: Text(
                                'Add To Favorite',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                insertToFavorite(data);
                                Toast.show('Added', context);
                                Navigator.of(context).pop();
                              },
                            );
                          } else {
                            return RaisedButton(
                              color: Colors.redAccent,
                              child: Text(
                                'Delete from Favorite',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                deleteFromFavorite(data);
                                Toast.show('Deleted', context);
                                Navigator.of(context).pop();
                              },
                            );
                          }
                        } else {
                          return RaisedButton(
                            color: Colors.white12,
                            child: Text(
                              'Please Wait',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          );
                        }
                      },
                    )
                  ],
                );
              } else {
                return spin.SpinKitFoldingCube(
                  color: Colors.blueAccent,
                );
              }
            },
          )),
    );
  }
}
