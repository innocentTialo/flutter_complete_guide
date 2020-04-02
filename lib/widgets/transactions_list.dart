 import '../models/transaction.dart';

final List<Transaction> transactions = [
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

  List<Transaction> get recentTransactions {
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

  List<Transaction> get userTransactions{
    return transactions;
  }
