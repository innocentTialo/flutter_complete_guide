import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../mock/dummy_data.dart';
import '../models/category.dart';

class CategoryMealsScreen extends StatelessWidget {
  static String routeName = '/category-meals';
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Category>;
    final category = routeArgs['category'];
    final categoryMeals = getMealsByCategoryId(category.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            var meal = categoryMeals[index];
            return MealItem(meal: meal);
          },
          itemCount: categoryMeals.length,
        ),
      ),
    );
  }
}
