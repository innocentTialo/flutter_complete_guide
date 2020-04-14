import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/order_item.dart';

class OrderProvider with ChangeNotifier {
 List<OrderItem> _items = [];

 List<OrderItem> get items {
   return [..._items];
 }

 void addItem(OrderItem item) {
   _items.add(item);
   notifyListeners();
 }
}