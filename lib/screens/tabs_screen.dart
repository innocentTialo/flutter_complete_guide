import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

import './categories_screen.dart';
import './favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  var _selectedIndex = 0;

  void onSelectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'screen': CategoriesScreen(), 'title': 'Categories'},
      {'screen': FavoriteScreen(widget.favoriteMeals), 'title': 'Favorites'},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text(_pages[_selectedIndex]['title']),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        //body: TabBarView(children: _pages), // triggered by tab bar
        body: _pages[_selectedIndex]
            ['screen'], // triggered by bottom navigation bar
        bottomNavigationBar: BottomNavigationBar(
          onTap: onSelectTab,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          //type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context)
                  .primaryColor, // in the case of shifting bottom navigation bar we need to explicitly give de background color of the navigation bar items
              icon: Icon(Icons.category),
              title: Text('Categories'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context)
                  .primaryColor, // in the case of shifting bottom navigation bar we need to explicitly give de background color of the navigation bar items
              icon: Icon(Icons.star),
              title: Text('Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
