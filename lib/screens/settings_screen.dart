import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = '/settings';
  final Map<String, bool> filters;
  final Function setFiltersHandler;

  const SettingsScreen({this.filters, this.setFiltersHandler});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filters['gluten'];
    _vegetarian = widget.filters['vegetarian'];
    _vegan = widget.filters['vegan'];
    _lactoseFree = widget.filters['lactose'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.setFiltersHandler(widget.filters);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Ajust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchListTile('Gluten-Free',
                    'Only include gluten-free meals.', _glutenFree, (value) {
                  setState(() {
                    widget.filters['gluten'] = value;
                    _glutenFree = value;
                  });
                }),
                buildSwitchListTile(
                    'Vegetarian', 'Only include vegetarian meals.', _vegetarian,
                    (value) {
                  setState(() {
                    widget.filters['vegetarian'] = value;
                    _vegetarian = value;
                  });
                }),
                buildSwitchListTile(
                    'Vegan', 'Only include vegan meals.', _vegan, (value) {
                  setState(() {
                    widget.filters['vegan'] = value;
                    _vegan = value;
                  });
                }),
                buildSwitchListTile('Lactose-Free',
                    'Only include lactose-free meals.', _lactoseFree, (value) {
                  setState(() {
                    widget.filters['lactose'] = value;
                    _lactoseFree = value;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  SwitchListTile buildSwitchListTile(
      String title, String description, bool currentValue, Function handler) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      subtitle: Text(description),
      onChanged: handler,
    );
  }
}
