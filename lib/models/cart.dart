


import 'dart:convert';

import 'package:resturant_website_app/models/categories.dart';

class Cart {

  List<Item> items;
  double totalItemPrice;
  int totalItemCount;

  Cart({this.items, this.totalItemPrice, this.totalItemCount});

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
      ),

      totalItemPrice: (json['cart_total'] as double),
      totalItemCount: json['cart_quantity']
  );

}