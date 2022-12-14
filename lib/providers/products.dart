import 'dart:convert';

import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imgurl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imgurl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imgurl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imgurl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var showFavouriteOnly=false;
  //
  // void showFavourite(){
  //     this.showFavouriteOnly=true;
  //     notifyListeners();
  // }
  //
  // void showAll(){
  //   this.showFavouriteOnly=false;
  //   notifyListeners();
  //
  // }

  List<Product> get items {
    // if(showFavouriteOnly){
    //   return _items.where((pro) => pro.isFavourite==true).toList();
    // }

    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((prod) => prod.isFavourite == true).toList();
  }

  Future<void> addProduct(Product product) {
    var url = Uri.parse(
        "https://shop-app-22862-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
    // var url=Uri.https("https://console.firebase.google.com/u/0/project/shop-app-22862/database/shop-app-22862-default-rtdb/data/~2Fauthority", "/products.json");
    return http
        .post(url,
            body: json.encode({
              "title": product.title,
              "description": product.description,
              "imgUrl": product.imgurl,
              "price": product.price,
              "isFavourite": product.isFavourite,
            }))
        .then((response) {
      final newProduct = Product(
        id: json.decode(response.body)["name"],
        description: product.description,
        title: product.title,
        imgurl: product.imgurl,
        price: product.price,
      );
      _items.insert(0, newProduct);
      notifyListeners();

    });

    // final newProduct = Product(
    //     id: DateTime.now().toString(),
    //     description: product.description,
    //     title: product.title,
    //     imgurl: product.imgurl,
    //     price: product.price,);

    // _items.insert(0, newProduct);

    // notifyListeners();
    // return Future.value();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void updateProduct(String id, Product newProduct) {
    var index = _items.indexWhere((prod) => prod.id == id);

    if (index >= 0) {
      _items[index] = newProduct;
      notifyListeners();
    } else {
      print("...");
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);

    notifyListeners();
  }
}
