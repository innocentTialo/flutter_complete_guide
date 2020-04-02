import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';

import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  /* SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.teal,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
                button: TextStyle(color: Colors.white),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _showCard = false;
  final List<Transaction> userTransactions = [
    Transaction(
      id: 0,
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
      id: 3,
      title: 'Restaurant',
      amount: 20,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 4,
      title: 'Phone battery',
      amount: 120,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 5,
      title: 'Breakfast',
      amount: 200,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 6,
      title: 'Phone credit',
      amount: 155,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return userTransactions
        .where(
          (transaction) => transaction.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _addNewTransaction(String title, String amount,
      [DateTime transactionDate]) {
    final newTransaction = Transaction(
      id: DateTime.now().hashCode,
      title: title,
      amount: double.parse(amount),
      date: transactionDate ?? DateTime.now(),
    );

    setState(() {
      userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(int transactionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Confirm deletion"),
          content: new Text("Do you really want to delete this transaction?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () => {
                setState(() {
                  userTransactions.removeWhere(
                    (transaction) => transaction.id == transactionId,
                  );
                  Navigator.of(context).pop();
                }),
              },
            ),
          ],
        );
      },
    );
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
    final mediaQuery = MediaQuery.of(context);

    var isLandscapeMode = mediaQuery.orientation == Orientation.landscape;

    var pageTitleWidget = Text('Personal expenses');
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: pageTitleWidget,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
            title: pageTitleWidget,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  startAddNewTransaction(context);
                },
              )
            ],
          );

    var deviceHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    var portraitChartWidget = Container(
      height: deviceHeight * 0.3,
      child: Chart(
        recentTransactions: _recentTransactions,
      ),
    );

    var portraitTransactionListWidget = Container(
      height: deviceHeight * 0.7,
      child: TransactionList(
          transactions: userTransactions, deletionHandler: _deleteTransaction),
    );

    var topSwitchWidget = Container(
      height: deviceHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show card',
            style: Theme.of(context).textTheme.title,
          ),
          Switch(
              value: _showCard,
              onChanged: (value) {
                setState(() {
                  _showCard = value;
                });
              }),
        ],
      ),
    );

    var landscapeChartWidget = Container(
      height: deviceHeight * 0.9,
      child: Chart(
        recentTransactions: _recentTransactions,
      ),
    );

    var landscapeTransactionListWidget = Container(
      height: deviceHeight * 0.9,
      child: TransactionList(
          transactions: userTransactions, deletionHandler: _deleteTransaction),
    );

    var pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: isLandscapeMode
              ? <Widget>[
                  topSwitchWidget,
                  _showCard
                      ? landscapeChartWidget
                      : landscapeTransactionListWidget
                ]
              : <Widget>[
                  portraitChartWidget,
                  portraitTransactionListWidget,
                ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).textTheme.button.color,
              ),
              onPressed: () {
                startAddNewTransaction(context);
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
