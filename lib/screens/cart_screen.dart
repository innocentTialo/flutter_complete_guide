import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_recap.dart';

class CartScreen extends StatelessWidget {
  static final String routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          CartRecap(cartProvider: cartProvider),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.itemCount,
              itemBuilder: (context, i) => CartItem(
                cartProvider.items.values.toList()[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
