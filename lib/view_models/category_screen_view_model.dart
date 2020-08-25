


import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';

class CategoryScreenViewModel {
  RemoteDataSource _apiResponse = RemoteDataSource();

  Future<Result<dynamic>> getItemsInCategory(int id) async {
    return _apiResponse.getItemsInCategory(id);
  }

  void addItemToCart(int id, Function completion) async {
    var result = _apiResponse.addItemToCart(id).then((value) {
      if (value is SuccessState) {
        completion();
      }
    });
  }

  Future<Result<dynamic>> getCart() async {
    return _apiResponse.getCart();
  }
}