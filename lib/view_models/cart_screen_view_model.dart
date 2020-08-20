

import 'package:flutter/cupertino.dart';
import 'package:resturant_website_app/models/cart.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';

class CartScreenViewModel extends ChangeNotifier {

  RemoteDataSource _apiResponse = RemoteDataSource();

  Future<Result<dynamic>> getCart() async {
    return _apiResponse.getCart();
  }

  void addItemToCart(int id, Function completion) async {
    return _apiResponse.addItemToCart(id).then((value) {
      if (value is SuccessState) {
        completion(true);
      }
    });
  }

  void changeItemQuantity(int itemId, int newQuantity, Function completion) async {
    return _apiResponse.updateItemInCart(itemId, newQuantity).then((value) {
      if (value is SuccessState) {
        Cart cart = (value as SuccessState).value;
        completion(true, cart);
      }
    });
  }
}