import 'package:flutter/material.dart';
import './food_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final FoodModel data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Hero(
                child: Image.network(data.thumbnail),
                tag: data.title,
              ),
            ),
            Text('Ingredients : \n\n'
                '${data.ingredients}\n\n\n'
                'more info :\n'
                '\n'
                ),
            GestureDetector(
                child: Text('${data.href}', style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                onTap: () {
                  _launchURL(data.href);
                }
            )
          ],
        ),
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
}
