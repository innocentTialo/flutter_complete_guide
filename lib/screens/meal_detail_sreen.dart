import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static String routeName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Meal>;
    final selectedMeal = routeArgs['meal'];
    var appBar = AppBar(
      title: Text('${selectedMeal.title}'),
    );
    var deviceHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: deviceHeight * 0.5,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildBoxTitle(deviceHeight, context, 'Ingredients'),
              buildBox(
                deviceHeight,
                selectedMeal,
                ListView.builder(
                  itemBuilder: (context, index) {
                    var igngredient = selectedMeal.ingredients[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Card(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          igngredient,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    );
                  },
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),
              buildBoxTitle(deviceHeight, context, 'Steps'),
              buildBox(
                deviceHeight,
                selectedMeal,
                ListView.builder(
                  itemBuilder: (context, index) {
                    var step = selectedMeal.steps[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('#${index + 1}'),
                            ),
                            title: Text(step),
                          ),
                          Divider()
                        ],
                      ),
                    );
                  },
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),
            ],
          ),
        ));
  }

  Container buildBox(double deviceHeight, Meal selectedMeal, Widget child) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.symmetric(vertical: 5),
      width: 300,
      constraints: BoxConstraints(maxHeight: (deviceHeight * 0.36) - 10),
      padding: EdgeInsets.all(5),
      child: child,
    );
  }

  Container buildBoxTitle(
      double deviceHeight, BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(
        top: deviceHeight * 0.02,
      ),
      height: deviceHeight * 0.05,
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}
