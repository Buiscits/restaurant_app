import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/my_app_bar_service.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/views/menu_screen.dart';
import 'package:resturant_website_app/widgets/my_appbar.dart';

import 'models/cart.dart';

void main() {
  setUpServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyAppBarService _appBarService = MyAppBarService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _appBarService.getCart(),
        builder: (context, snapshot) {
          if (snapshot.data is SuccessState) {

            Cart cart = (snapshot.data as SuccessState).value;

            return Scaffold(
              appBar: MyAppBar(context, 'Menu', cart),
              body: MenuScreen(),
            );
          } else if (snapshot.data is ErrorState) {
            return Text('error');
          } else{
            return CircularProgressIndicator();
          }
        },

      )
      //home: CheckoutScreen()
    );
  }
}
