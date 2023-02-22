import'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exceptions.dart';

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

  void toggleFavouriteStatus(String authToken) async {
    final oldStatus=isFavourite;
    isFavourite=!isFavourite!;
    notifyListeners();

    var url = Uri.parse(
        "https://shoping-f8ede-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");

    try {
      final response=await http.patch(url,body: json.encode({
        "isFavourite":isFavourite,
      }));
      if(response.statusCode>=400){
        isFavourite=oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavourite=oldStatus;
      notifyListeners();
      throw HttpException("Unable to add to favourites");
    }

  }
}
