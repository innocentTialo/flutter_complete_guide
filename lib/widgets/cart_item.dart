import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart' as cartItemModel;

class CartItem extends StatelessWidget {
  final cartItemModel.CartItem cartItem;

  const CartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 15),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      onDismissed: (_) => Provider.of<CartProvider>(
        context,
        listen: false,
      ).deleteItem(cartItem.product.id),
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text('\$${cartItem.product.price}'),
              ),
            ),
          ),
          title: Text(cartItem.product.title),
          subtitle: Text('\$${cartItem.product.price * cartItem.quantity}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }
}
