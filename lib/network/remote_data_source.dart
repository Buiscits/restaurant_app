



import 'dart:async';

import 'package:http/http.dart';
import 'package:resturant_website_app/models/cart.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/network_response.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/menu_client.dart';
import 'package:resturant_website_app/utils/request_type.dart';

class RemoteDataSource {

  RemoteDataSource._privateConstructor();
  static final RemoteDataSource _apiResponse = RemoteDataSource._privateConstructor();
  factory RemoteDataSource() => _apiResponse;

  MenuClient client = MenuClient(Client());

  String sessionCookie = '';


  Future<Result> getMenu() async {
    try {
      final response = await client.request(requestType: RequestType.GET, cookie: this.sessionCookie,  path: "menu/cats");
      if (response.statusCode == 200) {

        if (response.headers['set-cookie'] != null) {
          this.sessionCookie = response.headers['set-cookie'];
        }

        return Result<Menu>.success(Menu.fromRawJson(response.body));
      } else {
        return Result.error('Failed to get menu json');
      }
    } catch (error) {
      return Result.error('Something went wrong when requesting Menu');
    }
  }

  Future<Result> getItemsInCategory(int id) async {
    try {
      final response = await client.request(requestType: RequestType.GET, cookie: this.sessionCookie, path: "menu/items/?cat_id=$id",);
      if (response.statusCode == 200) {
        return Result<CategoryItems>.success(CategoryItems.fromRawJson(response.body));
      } else {
        return Result.error('Failed to get menu json');
      }
    } catch (error) {
      return Result.error('Something went wrong when requesting Menu');
    }
  }

  Future<Result> getCart() async {
    try {
      final response = await client.request(requestType: RequestType.GET, cookie: this.sessionCookie, path: "cart",);
      if (response.statusCode == 200) {
        return Result<Cart>.success(Cart.fromRawJson(response.body));
      } else {
        return Result.error('Failed to get menu json');
      }
    } catch (error) {
      return Result.error('Something went wrong when requesting Cart');
    }
  }

  void addItemToCart(int id) async {

    try {
      //2
      final response = await client.request(
          requestType: RequestType.POST, path: "cart", cookie: this.sessionCookie, parameter: {"item_id": id});
      if (response.statusCode == 200) {
        //3
        print('Added');
        //print(response.headers[]);

      } else {
        print('Else');
      }
    } catch (error) {
      print('error');
    }
  }
}