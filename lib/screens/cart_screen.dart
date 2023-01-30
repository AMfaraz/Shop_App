import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "./CartScreen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                SizedBox(width: 20),
                Chip(
                  label: Text(
                    "${cart.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleLarge
                            ?.color),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                // TextButton(
                //   onPressed: cart.totalAmount<=0? null:() {
                //     Provider.of<Orders>(context, listen: false)
                //         .addOrder(cart.items.values.toList(), cart.totalAmount);
                //     cart.clearCart();
                //   },
                //   child: const Text("Order Now"),
                //   style: TextButton.styleFrom(
                //       primary: Theme.of(context).primaryColor),
                // ),
                OrderButton(cart: cart),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (BuildContext context, int i) {
                return CartItem(
                    id: cart.items.values.toList()[i].id,
                    productId: cart.items.keys.toList()[i],
                    quantity: cart.items.values.toList()[i].quantity,
                    price: cart.items.values.toList()[i].price,
                    title: cart.items.values.toList()[i].title);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final cart;

  const OrderButton({required this.cart});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0  || _isLoading==true)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
            },
      child:_isLoading==true? CircularProgressIndicator(): const Text("Order Now"),
      style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
    );
  }
}
