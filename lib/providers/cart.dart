import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({required this.id,
    required this.title,
    required this.quantity,
    required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int? get itemCount {
    return _items.length == 0 ? 0 : _items.length;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartItem) {
      total = total + cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    bool doesContain = _items.containsKey(productId);
    if (doesContain) {
      _items.update(
          productId,
              (existingItem) =>
              CartItem(
                  id: existingItem.id,
                  title: existingItem.title,
                  quantity: existingItem.quantity + 1,
                  price: existingItem.price));
    } else {
      _items.putIfAbsent(
          productId,
              () =>
              CartItem(
                  id: DateTime.now().toString(),
                  title: title,
                  quantity: 1,
                  price: price));
    }
    notifyListeners();
  }

  void removeItem(String itemID) {
    _items.remove(itemID);
    notifyListeners();
  }

  void removeSingleItem(String prodKey) {
    if (!_items.containsKey(prodKey)) {
      return;
    }
    else if ((_items[prodKey]?.quantity)! > 1) {
      _items.update(prodKey, (oldItem) =>
          CartItem(id: oldItem.id,
              title: oldItem.title,
              quantity: oldItem.quantity - 1,
              price: oldItem.price));
    }
    else {
      _items.remove(prodKey);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }


}
