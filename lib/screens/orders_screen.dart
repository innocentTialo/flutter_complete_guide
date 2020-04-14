import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/order_provider.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static final routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orderProvider.items.length,
        itemBuilder: (ctx, i) => OrderItem(
          orderProvider.items[i],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
