import 'package:flutter/material.dart';
import './ui/home.dart';
import './ui/detail.dart';
import './config.dart';
import 'package:http/http.dart' as http;
void main() {
  Config.appFlavor = Flavor.DEV;
  runApp(MaterialApp(
    title: 'Food Lisuto',
    initialRoute: '/',
    routes: {
      '/': (context) =>
          Home(
            appName: Config.appName,
          ),
      '/detail':(context)=>Detail()
    },
  ));
}
