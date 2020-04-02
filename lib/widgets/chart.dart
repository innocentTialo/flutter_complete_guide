import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({@required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(
            days: index,
          ),
        );

        var sumOfdailyExpense = 0.0;

        recentTransactions.forEach(
          (transaction) {
            if (transaction.date.year == weekDay.year &&
                transaction.date.month == weekDay.month &&
                transaction.date.day == weekDay.day) {
              sumOfdailyExpense += transaction.amount;
            }
          },
        );

        return {
          'day': index == 0
              ? 'Today'
              : index == 1 ? 'Yesterday' : DateFormat.E().format(weekDay),
          'amount': sumOfdailyExpense
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    var sumOfLastTransactions = 0.0;
    recentTransactions.forEach((t) {
      sumOfLastTransactions += t.amount;
    });
    print(groupedTransactionValues);
    return Card(
        elevation: 2,
        margin: const EdgeInsets.all(10),
        child: /*  Column(
        children: <Widget>[ */
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (tx) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: tx['day'],
                    spendingAmount: tx['amount'],
                    spendingPctOfTotal: sumOfLastTransactions != 0
                        ? (tx['amount'] as double) / sumOfLastTransactions
                        : 0,
                  ),
                ),
              )
              .toList(),
        ) /* ,
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Expenses of the lasts seven days",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          )
        ],
      ), */
        );
  }
}
