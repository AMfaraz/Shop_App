import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'package:ship_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String? id;
  final double? price;
  final int? quantity;
  final String? title;
  final String? productId;

  CartItem(
      {required this.id,
      required this.productId,
      required this.quantity,
      required this.price,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId!);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FittedBox(child: Text("\$$price"))),
            ),
            title: Text(
              title!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Total: \$${price! * quantity!}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are you sure"),
                  content: Text("Do you want to remove the item from the cart"),
                  actions: <Widget>[
                    TextButton(onPressed: () {Navigator.of(context).pop(false);}, child: Text("No")),
                    TextButton(onPressed: () {Navigator.of(context).pop(true);}, child: Text("Yes"))
                  ],
                ));
      },
    );
  }
}
