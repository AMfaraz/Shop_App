import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({required this.id,
    required this.dateTime,
    required this.amount,
    required this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final authToken;

  Orders(this._orders,this.authToken);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        "https://shoping-f8ede-default-rtdb.firebaseio.com/orders.json?auth=$authToken");

    final timeStamp = DateTime.now();

    final response = await http.post(url,
        body: json.encode({
          "amount": total,
          "datetime": timeStamp.toIso8601String(),
          "products": cartProducts.map((e) {
            return {
              "id": e.id,
              "title": e.title,
              "quantity": e.quantity,
              "price": e.price,
            };
          }).toList(),
        }));

    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)["name"],
            dateTime: timeStamp,
            amount: total,
            products: cartProducts));
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        "https://shoping-f8ede-default-rtdb.firebaseio.com/orders.json?auth=$authToken");
    final response = await http.get(url);

    List<OrderItem> loadedOrders = [];
    final Map<String,dynamic>? extractedData = json.decode(response.body) as Map<String, dynamic>;

    if(extractedData==null){
      return;
    }
    extractedData.forEach((orderId, orderDate) {
      loadedOrders.add(OrderItem(id: orderId,
          dateTime: DateTime.parse(orderDate["datetime"]),
          amount: orderDate["amount"],
          products: (orderDate["products"] as List<dynamic>).map((item) {
            return CartItem(id: item["id"], title: item["title"], quantity: item["quantity"], price: item["price"]);
          }).toList()));
    });
    // print(json.decode(response.body));
    _orders=loadedOrders.reversed.toList();
    notifyListeners();
  }
}
