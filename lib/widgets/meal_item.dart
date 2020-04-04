import 'package:flutter/material.dart';

import '../enum/affordability.dart';
import '../enum/complexity.dart';
import '../screens/meal_detail_sreen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({@required this.meal});

  void onSelectMeal(BuildContext context) {
    Navigator.pushNamed(context, MealDetailScreen.routeName, arguments: {'meal': meal});
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 350),
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    color: Colors.black26,
                    child: Text(
                      meal.title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    buildBottomIcon(
                      context,
                      Icons.schedule,
                      '${meal.duration}min',
                    ),
                    buildBottomIcon(
                      context,
                      Icons.work,
                      '${getComplexityText(meal.complexity)}',
                    ),
                    buildBottomIcon(
                      context,
                      Icons.attach_money,
                      '${getAffordabilityText(meal.affordability)}',
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Row buildBottomIcon(BuildContext context, IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black54,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
