import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool onlyFavourites;

  ProductsGrid({required this.onlyFavourites});


  @override
  Widget build(BuildContext context) {
    final productsData=Provider.of<Products>(context);
    final products=onlyFavourites?productsData.favouriteItems:productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value:products[index],
          child: ProductItem(
            // imgurl: products[index].imgurl,
            // title: products[index].title,
            // id: products[index].id,
          ),
        );
      },
    );
  }
}