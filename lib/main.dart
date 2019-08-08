import 'package:flutter/material.dart';
import './ui/home.dart';
import './ui/detail.dart';
void main() async{
  runApp(MaterialApp(
    title: 'Food Lisuto',
    initialRoute: '/',
    routes: {
      '/':(context)=> Home(),
      '/detail':(context)=>Detail()
    },
  ));
}
