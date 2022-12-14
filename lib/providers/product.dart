import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imgurl;
  bool? isFavourite;

  Product(
      {required this.id,
      required this.description,
      required this.title,
      required this.imgurl,
      required this.price,
      this.isFavourite=false});

  void toggleFavouriteStatus(){
    isFavourite=!isFavourite!;
    notifyListeners();
  }
}
