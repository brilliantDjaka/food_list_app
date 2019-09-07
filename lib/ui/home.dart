import 'package:flutter/material.dart';
import 'package:food_list_by_brian/config.dart';
import './home/main_view.dart';
import './home/favorite_view.dart';
import './home/search_view.dart';

class Home extends StatefulWidget {
  String appName = '';

  Home({this.appName});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int bottomBarCurrent = 0;
  TabController tabController;
  bool isSearch = false;
  String searchString = '';

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
        backgroundColor: Config.primaryColor,
        title: Row(
          children: <Widget>[
            Config.appIcon,
            Text(' ' + widget.appName, key: Key('title'),)
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.search),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SearchView();
                  }
              ));
            },
          )
        ],
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
        labelColor: Config.secondaryColor,
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
