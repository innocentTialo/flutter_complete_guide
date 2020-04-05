import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoriteScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: favoriteMeals.isEmpty
          ? Text('You have not favorite meal yet!')
          : ListView.builder(
              itemBuilder: (context, index) {
                var meal = favoriteMeals[index];
                return MealItem(meal: meal);
              },
              itemCount: favoriteMeals.length,
            ),
    );
  }
}
