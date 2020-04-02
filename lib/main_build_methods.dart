import 'package:flutter/material.dart';

import './widgets/transactions_list.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

Container _buildTransactionListWidget({
  @required double transactionsWidgetHeight,
  @required Function deletionHandler,
}) {
  return Container(
    height: transactionsWidgetHeight,
    child: TransactionList(
      transactions: userTransactions,
      deletionHandler: deletionHandler,
    ),
  );
}

Container _buildChartWidget({
  double chartWidgetHeight,
}) {
  return Container(
    height: chartWidgetHeight,
    child: Chart(
      recentTransactions: recentTransactions,
    ),
  );
}

Container _buildTopSwitchWidget(double deviceHeight, BuildContext context,
    Function onChange, bool showCard) {
  return Container(
    height: deviceHeight * 0.1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Show card',
          style: Theme.of(context).textTheme.title,
        ),
        Switch(
            value: showCard,
            onChanged: (value) {
              onChange(value);
            }),
      ],
    ),
  );
}

Widget buildPageBody(
    {@required double deviceHeight,
    @required MediaQueryData mediaQueryData,
    @required BuildContext context,
    @required Function deletionHandler,
    @required Function switchOnChangeHandler,
    @required bool showCard}) {
  var isLandscapeMode = mediaQueryData.orientation == Orientation.landscape;
  return SafeArea(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: isLandscapeMode
            ? <Widget>[
                _buildTopSwitchWidget(
                    deviceHeight, context, switchOnChangeHandler, showCard),
                showCard
                    ? _buildChartWidget(chartWidgetHeight: deviceHeight * 0.9)
                    : _buildTransactionListWidget(
                        transactionsWidgetHeight: deviceHeight * 0.9,
                        deletionHandler: deletionHandler)
              ]
            : <Widget>[
                _buildChartWidget(chartWidgetHeight: deviceHeight * 0.3),
                _buildTransactionListWidget(
                  transactionsWidgetHeight: deviceHeight * 0.7,
                  deletionHandler: deletionHandler,
                ),
              ],
      ),
    ),
  );
}
