import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_products_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName="./user_products_screen";

  Future<void> _refreshProducts(BuildContext context) async {
    Provider.of<Products>(context,listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Yours Products"),
        actions: <Widget>[
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
          return _refreshProducts(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  UserProductsItem(
                      id: productsData.items[i].id!,
                      title: productsData.items[i].title!,
                      imgUrl: productsData.items[i].imgurl!
                  ),
                  const Divider(),
                ],
              );
            },
            itemCount: productsData.items.length,
          ),
        ),
      ),
    );
  }
}
