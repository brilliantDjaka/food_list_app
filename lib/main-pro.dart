import 'package:flutter/material.dart';
import './ui/home.dart';
import './ui/detail.dart';
import './config.dart';

void main() async {
  Config.appFlavor = Flavor.PRO;
  runApp(MaterialApp(
    title: 'Food Lisuto',
    initialRoute: '/',
    routes: {
      '/': (context) => Home(
            appName: Config.appName,
          ),
      '/detail': (context) => Detail()
    },
  ));
}
