import 'package:flutter/material.dart';
import './home/main_view.dart';
import './home/favorite_view.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int bottomBarCurrent = 0;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,

    );
  }

  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Lisuto'),
        centerTitle: true,
      ),
      body: TabBarView(
        children: <Widget>[
          MainView(category: 'Dessert'),
          MainView(category: 'Seafood'),
          FavoriteView()

        ],
        controller: tabController,
      ),
      bottomNavigationBar: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.blue,
        tabs: <Widget>[
          Tab(text: 'Dessert', icon: Icon(Icons.fastfood)),
          Tab(text: 'Seafood', icon: Icon(Icons.cake)),
          Tab(text: 'Favorite', icon: Icon(Icons.favorite))
        ],
        controller: tabController,

      ),
    );
  }

}
