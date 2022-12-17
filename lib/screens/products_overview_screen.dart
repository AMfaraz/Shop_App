import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../providers/products.dart';

enum FilterOptions{
  Favourite,
  All,
}


class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites=false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer=Provider.of<Products>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
        actions:<Widget>[
          PopupMenuButton(icon:Icon(Icons.more_vert),itemBuilder: (_)=>[
            const PopupMenuItem(child: Text("Only Favourites"),value: FilterOptions.Favourite,),
            const PopupMenuItem(child: Text("Show all"),value: FilterOptions.All,)
          ],
          onSelected: (FilterOptions selectedValue) {
            setState((){
              if(selectedValue==FilterOptions.Favourite){
                // productsContainer.showFavourite();
                _showOnlyFavourites=true;
              }
              else{
                // productsContainer.showAll();
                _showOnlyFavourites=false;
              }
            });
          },),
        ],
      ),
      body: ProductsGrid(onlyFavourites:_showOnlyFavourites),
    );
  }
}


