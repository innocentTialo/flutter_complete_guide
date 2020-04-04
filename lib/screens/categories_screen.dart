import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../mock/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliMeals'),
      ),
      body: GridView(
        padding: EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
            .map(
              (category) => CategoryItem(category: category),
            )
            .toList(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
      ),
    );
  }
}
