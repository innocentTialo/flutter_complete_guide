import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart' as OrderItemModel;

class OrderItem extends StatefulWidget {
  final OrderItemModel.OrderItem orderItem;

  const OrderItem(this.orderItem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 2,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.orderItem.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.orderItem.date)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() {
                _expanded = !_expanded;
              }),
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.orderItem.items.length * 20.0 + 20, 120),
              child: ListView.builder(
                itemCount: widget.orderItem.items.length,
                itemBuilder: (ctx, i) => OrderListItem(
                  widget.orderItem.items[i],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final CartItem cartItem;

  OrderListItem(this.cartItem);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 4,
        left: 20,
        right: 35,
        bottom: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${cartItem.product.title} ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '(\$${cartItem.product.price})',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          Spacer(),
          Text('${cartItem.quantity}x'),
        ],
      ),
    );
  }
}
