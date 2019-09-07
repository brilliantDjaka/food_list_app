import 'package:flutter/material.dart';
import 'package:food_list_by_brian/config.dart';
import './main_view.dart';
import '../../helper/request.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spin;
import 'package:http/http.dart' as http;

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  String searchString;

  Widget build(BuildContext context) {
    RequestHelper request = RequestHelper();
    MainView mainView = MainView();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        title: TextField(
          onChanged: (text) {
            setState(() {
              searchString = text;
            });
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.cancel),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: request.searchFood(
              searchString: searchString, http: http.Client()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (Config.isDebug) {
                print(snapshot.data);
              }
              if (snapshot.data == false || snapshot.data.length == 0) {
                return Center(
                  child: ListTile(
                    title: Icon(
                      Icons.warning,
                      color: Config.primaryColor,
                      size: 100,
                    ),
                    subtitle: Text(
                      'No Data',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, color: Config.primaryColor),
                    ),
                  ),
                );
              }
              return GridView.count(
                  crossAxisCount: 2,
                  children: mainView.getFoodMenu(
                      listFood: snapshot.data, context: context));
            } else if (snapshot.hasError) {
              return Center(
                child: ListTile(
                  title: Icon(
                    Icons.warning,
                    color: Config.primaryColor,
                    size: 100,
                  ),
                  subtitle: Text(
                    'No Data',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Config.primaryColor),
                  ),
                ),
              );
            } else {
              return Center(
                child: spin.SpinKitFoldingCube(
                  color: Config.primaryColor,
                ),
              );
            }
          }),
    );
  }
}
