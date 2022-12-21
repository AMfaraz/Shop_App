import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ship_app/screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String? imgurl;
  // final String? title;
  // final String? id;

  // ProductItem({required this.imgurl, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    final Product loadedProduct=Provider.of<Product>(context,listen: false);
    final Cart itemCart=Provider.of<Cart>(context,listen: false);

    return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                child: GestureDetector(
                  child: Image.network(
                    loadedProduct.imgurl!,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductDetailScreen.routeName,
                      arguments: loadedProduct.id,
                    );
                  },
                ),
                footer: GridTileBar(
                  title: Text(
                    loadedProduct.title!,
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Colors.black87,
                  leading: Consumer<Product>(builder: (context,loadedProduct,child)=>IconButton(
                    icon: Icon(loadedProduct.isFavourite!
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      loadedProduct.toggleFavouriteStatus();
                    },
                  )),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      itemCart.addItem(loadedProduct.id!,loadedProduct.price!,loadedProduct.title!);
                    },
                  ),
                ),
              ),
            );
  }
}
