import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/abstract_summary.dart';
import 'package:flutter_complete_guide/models/order_item.dart';
import 'package:flutter_complete_guide/providers/abstract_repository.dart';

class OrderProvider extends AbstractRepository with ChangeNotifier {
 List<OrderItem> _items = [];

 List<OrderItem> get items {
   return [..._items];
 }

 void addItem(OrderItem item) {
   _items.add(item);
   notifyListeners();
 }

  @override
  String getControllerName() {
    // TODO: implement getControllerName
    return null;
  }

  @override
  AbstractSummaryDto toSummaryDto(String json) {
    // TODO: implement toSummaryDto
    return null;
  }
}