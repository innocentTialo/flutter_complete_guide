import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/order_item.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class CartRecap extends StatelessWidget {
  const CartRecap({
    @required this.cartProvider,
  });

  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Total',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Chip(
              label: Text(
                '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.title.color,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            FlatButton(
              child: Text('ORDER NOW'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                var orderProvider = Provider.of<OrderProvider>(context, listen: false);
                var order = OrderItem(
                  DateTime.now().toString(),
                  cartProvider.totalAmount,
                  DateTime.now(),
                  cartProvider.items.values.toList(),
                );
                orderProvider.addItem(order);
                cartProvider.clearItems();
                Navigator.pushReplacementNamed(context, OrdersScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
