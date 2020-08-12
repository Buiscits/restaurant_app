

import 'dart:convert';

import 'categories.dart';

class CheckoutCompleted {

  final int orderNumber;
  final String date;
  final double subtotal;
  final String tableNumber;

  //final List<Item> items;

  CheckoutCompleted({this.orderNumber, this.date, this.subtotal, this.tableNumber});//, this.items});

  factory CheckoutCompleted.fromRawJson(String str) =>
      CheckoutCompleted.fromJson(jsonDecode(str));

  factory CheckoutCompleted.fromJson(Map<String, dynamic> json) => CheckoutCompleted(

    orderNumber: json['orderNumber'],
    date: json['date'],
    subtotal: json['subtotal'],
    tableNumber: json['table_number']

    /*
      items: List<Item>.from(
          json.map((x) => Item(
              name: x['post_title'],
              itemId: x['ID'],
              price: double.parse(x['price'][0]),
              quantity: 1))
      )

     */
  );
}