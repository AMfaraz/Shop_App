import 'package:flutter/material.dart';
import 'package:ship_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String? imgurl;
  final String? title;
  final String? id;

  ProductItem({required this.imgurl, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            imgurl!,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: id,
            );
          },
        ),
        footer: GridTileBar(
          title: Text(
            title!,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Theme
                .of(context)
                .accentColor,
            onPressed: () {
              print("hello");
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart,),
            color: Theme
                .of(context)
                .accentColor,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
