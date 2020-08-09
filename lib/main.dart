import 'package:flutter/material.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/views/backdrop_screen.dart';
import 'package:resturant_website_app/views/checkout_screen.dart';
import 'package:resturant_website_app/views/menu_screen.dart';

void main() {
  setUpServiceLocator();
  runApp(MyApp());
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BackdropScreen(),
    );
  }
}

 */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuScreen(),
      //home: CheckoutScreen()
    );
  }
}
