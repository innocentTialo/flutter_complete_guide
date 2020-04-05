import 'package:flutter/material.dart';

import '../screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text(
            'Cooking up!',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 26,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        buildListTile('Meals', Icons.restaurant, (){
          Navigator.of(context).pushReplacementNamed('/');
        }),
        buildListTile('Settings', Icons.settings, (){
          Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
        }),
      ],
    ));
  }

  ListTile buildListTile(String title, IconData iconData, Function handler) {
    return ListTile(
        leading: Icon(
          iconData,
          size: 26,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: handler,
      );
  }
}
