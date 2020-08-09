


import 'dart:convert';

import 'package:resturant_website_app/models/categories.dart';

class Cart {
  List<Item> items;

  Cart({this.items});

  factory Cart.fromRawJson(String str) => 
      Cart.fromJson(jsonDecode(str));


  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      items: List<Item>.from(
          json['cart_items'].map((item) => Item(
              name: item['post_title'],
              itemId: item['ID'],
              price: double.parse(item['price'][0]),
              quantity: item['quantity']
          ))
      )
  );

}