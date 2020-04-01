import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar({
    @required this.label,
    @required this.spendingAmount,
    @required this.spendingPctOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: 15,
            child: FittedBox(
              child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: 1 - spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 200, 1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          FittedBox(
            child: Text(
              label,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      );
    });
  }
}
