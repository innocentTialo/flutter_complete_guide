import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import './main_build_methods.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transactions_list.dart';

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
        textTheme: newTextTheme(18),
        appBarTheme: AppBarTheme(
          textTheme: newTextTheme(20),
        ),
      ),
      home: MyHomePage(),
    );
  }

  TextTheme newTextTheme(double fontSize) {
    return ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: fontSize,
          ),
          button: TextStyle(color: Colors.white),
        );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _showCard = false;

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

  void switchOnChangeHandler(value) {
    setState(() {
      _showCard = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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

    var pageBody = buildPageBody(
      deviceHeight: deviceHeight,
      mediaQueryData: mediaQuery,
      context: context,
      deletionHandler: _deleteTransaction,
      switchOnChangeHandler: switchOnChangeHandler,
      showCard: _showCard,
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
