import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';

import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  /* String tileInput;
  String amountInput; */

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactions = [
    Transaction(
      id: 1,
      title: 'New Shirt',
      amount: 70,
      date: DateTime.now(),
    ),
    Transaction(
      id: 1,
      title: 'New shoes',
      amount: 90,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 2,
      title: 'Weekly Groceries',
      amount: 52.99,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 2,
      title: 'Restaurant',
      amount: 20,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 2,
      title: 'Weekly Groceries',
      amount: 120,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 2,
      title: 'Weekly Groceries',
      amount: 200,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 2,
      title: 'Weekly Groceries',
      amount: 155,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: 2,
      title: 'Weekly Groceries',
      amount: 59.99,
      date: DateTime.now().subtract(Duration(days: 7)),
    )
  ];

  List<Transaction> get _recentTransactions {
    return userTransactions.where(
      (transaction) => transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      ),
    ).toList();
  }

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

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions: _recentTransactions,),
            TransactionList(transactions: userTransactions)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
