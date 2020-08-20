

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:resturant_website_app/models/cart.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';

class CartScreenViewModel {

  RemoteDataSource _apiResponse = RemoteDataSource();

  StreamController<Result> streamController;

  CartScreenViewModel() {
    streamController = StreamController();
  }


  void dispose() {
    streamController.close();
  }

  void getCart() async =>_apiResponse.getCart().then((value) => streamController.add(value));

  void changeItemQuantity(int itemId, int newQuantity, Function completion) async {
    return _apiResponse.updateItemInCart(itemId, newQuantity).then((value) {

      streamController.add(value);

      if (value is SuccessState) {
        completion(true);
      }
    });
  }


}