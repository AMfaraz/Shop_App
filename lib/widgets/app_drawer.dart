import 'package:flutter/material.dart';

import '../screens/order_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text("Drawer"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Orders"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Manage Products"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  UserProductsScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
