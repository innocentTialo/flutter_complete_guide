import 'package:flutter/material.dart';

import './models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({Key key, this.category}) : super(key: key);

  onSelectCategory(BuildContext context) {
   /*  Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return CategoryMealsScreen(
            category: category,
          );
        },
      ),
    ); */
    Navigator.of(context).pushNamed('/category-meals', arguments: {'category': category});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelectCategory(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.7),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
