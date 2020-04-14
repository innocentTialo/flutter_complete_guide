import 'package:flutter_complete_guide/models/cart_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime date;
  final List<CartItem> items;

  OrderItem(
    this.id,
    this.amount,
    this.date,
    this.items,
  );
}
