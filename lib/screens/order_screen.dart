import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatefulWidget {
  static final routeName="./ordersScreen";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  void initState(){
    Future.delayed(Duration.zero).then((_){
      Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
    });
    super.initState();
  }
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
      drawer: AppDrawer(),
    );
  }
}
