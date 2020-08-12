


import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';

class CategoryScreenViewModel extends ChangeNotifier {
  RemoteDataSource _apiResponse = RemoteDataSource();

  Future<Result<dynamic>> getItemsInCategory(int id) async {
    return _apiResponse.getItemsInCategory(id);
  }

  void addItemToCart(int id) async {
    _apiResponse.addItemToCart(id);
  }
}