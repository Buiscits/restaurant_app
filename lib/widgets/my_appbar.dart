

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/cart.dart';
import 'package:resturant_website_app/views/cart_screen.dart';

Widget MyAppBar(BuildContext context, String title, Cart cart) {
  return AppBar(
    title: Text('$title'),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 20),
        child: GestureDetector(

          child: Row(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text('£ ${cart.totalItemPrice}'),
              ),

              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text('(${cart.totalItemCount})'),
              ),

              Icon(Icons.shopping_basket),



            ],
          ),

          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartScreen()
                )).then((value) => () {
              //waitForCart();
            });
          },
        ),
      ),

    ],
  );
}