import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';
import 'empty_list_view.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletionHandler;

  const TransactionList(
      {@required this.transactions, @required this.deletionHandler});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? EmptyListViewWidget(
            title: 'No transaction added yet!',
          )
        : /* ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  transaction: transactions[index],
                  deletionHandler: deletionHandler);
            },
            itemCount: transactions.length,
          ) */
        ListView(
            children: transactions
                .map((transaction) => TransactionItem(
                      key: ValueKey(transaction.id),
                      transaction: transaction,
                      deletionHandler: deletionHandler,
                    ))
                .toList(),
          );
  }
}
