import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';
import '../mock/dummy_data.dart';
import '../models/category.dart';

class CategoryMealsScreen extends StatelessWidget {
  static String routeName = '/category-meals';
  final Map<String, bool> filters;

  const CategoryMealsScreen({this.filters});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Category>;
    final category = routeArgs['category'];
    final categoryMeals = getMealsByCategoryId(category.id);

    List<Meal> mealsMatchingFilters = categoryMeals.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }
      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            var meal = mealsMatchingFilters[index];
            return MealItem(meal: meal);
          },
          itemCount: mealsMatchingFilters.length,
        ),
      ),
    );
  }
}
