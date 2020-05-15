import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((_, cartItem) {
      total += (cartItem.product.price * cartItem.quantity);
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void deleteItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }

    if (_items[id].quantity > 1) {
      _items.update(
        id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      deleteItem(id);
    }
  }

  void clearItems() {
    _items = {};
    notifyListeners();
  }
}
