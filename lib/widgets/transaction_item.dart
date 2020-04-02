import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    @required Key key,
    @required this.transaction,
    @required this.deletionHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deletionHandler;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  var _bgColor;

  @override
  void initState() {
    const colors = [
      Colors.green,
      Colors.blue,
      Colors.black,
      Colors.purple,
    ];

    _bgColor = colors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 25,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                label: const Text("Delete"),
                icon: const Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                onPressed: () {
                  widget.deletionHandler(widget.transaction.id);
                },
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  widget.deletionHandler(widget.transaction.id);
                },
              ),
      ),
    );
  }
}
