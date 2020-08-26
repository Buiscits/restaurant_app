import 'package:flutter/material.dart';
import 'package:resturant_website_app/services/my_app_bar_service.dart';
import 'package:resturant_website_app/views/menu_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyAppBarService _appBarService = MyAppBarService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuScreen(),
    );
  }

}

