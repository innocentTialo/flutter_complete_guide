import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({@required this.transactions});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                "No transaction added yet!",
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : Container(
            height: 300,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "\$${transactions[index].amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            DateFormat("MMM d, yyyy")
                                .format(transactions[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
          );
  }
}
