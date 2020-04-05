import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/mock/dummy_data.dart';

import './models/meal.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_sreen.dart';
import './screens/category_meals_screen.dart';
import './screens/settings_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false,
  };

  void _setFilters(Map<String, bool> configuredFilters) {
    setState(() {
      filters = configuredFilters;
    });
  }

  List<Meal> _favoriteMeals = [];

  void toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere(
      (meal) => meal.id == mealId,
    );

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere(
            (meal) => meal.id == mealId,
          ),
        );
      });
    }
  }

  bool isMealFavorite(String mealId){
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ))),
      //home: TabsScreen(),
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
              filters: filters,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(toggleFavorite, isMealFavorite),
        SettingsScreen.routeName: (context) =>
            SettingsScreen(filters: filters, setFiltersHandler: _setFilters),
      },
    );
  }
}
