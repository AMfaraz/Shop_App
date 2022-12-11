import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String? imgurl;
  final String? title;
  final String? id;

  ProductItem({required this.imgurl, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imgurl!,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        title: Text(
          title!,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(Icons.favorite),
          onPressed: (){
            print("hello");
          },
        ),
        trailing:IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: (){},
        ),
      ),
    );
  }
}
