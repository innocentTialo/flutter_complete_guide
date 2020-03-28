import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> userTransactions = [
    Transaction(
      id: 1,
      title: 'New shoes',
      amount: 65.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 2,
      title: 'Weekly Groceries',
      amount: 52.99,
      date: DateTime.now(),
    )
  ];

  void _addNewTransaction(String title, String amount) {
    final newTransaction = Transaction(
      id: 3,
      title: title,
      amount: double.parse(amount),
      date: DateTime.now(),
    );

    setState(() {
      userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(transactions: userTransactions)
      ],
    );
  }
}
