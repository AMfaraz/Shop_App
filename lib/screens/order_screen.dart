import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersObj = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OrdresScreen"),
      ),
      body: ListView.builder(
        itemCount: ordersObj.orders.length,
        itemBuilder: (ctx,i){
          return OrderItem(order: ordersObj.orders[i]);
        },
      ),
    );
  }
}
