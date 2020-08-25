

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/cart.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/my_app_bar_service.dart';
import 'package:resturant_website_app/views/cart_screen.dart';



class MyAppBar extends StatefulWidget implements PreferredSizeWidget {

  final title;

  MyAppBar({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


class MyAppBarState extends State<MyAppBar> {

  MyAppBarService _appBarService = MyAppBarService();

  Future<Result<dynamic>> cartFuture;

  StreamController<Result> streamController;

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
    loadAppBarData();
  }

  void loadAppBarData() async => _appBarService.getCart().then((value) {
    streamController.add(value);
  });

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is SuccessState) {

            Cart cart = (snapshot.data as SuccessState).value;

            return AppBar(
              title: Text(widget.title),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(

                    child: Row(
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: cart.totalItemCount == 0 ? Text('') : Text('£${cart.totalItemPrice.toStringAsFixed(2)}'),
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: cart.totalItemCount == 0 ? Text('') : Text('(${cart.totalItemCount})'),
                        ),

                        Icon(Icons.shopping_basket),

                      ],
                    ),

                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()
                          )).then((value) {
                            this.loadAppBarData();
                      });
                    },
                  ),
                ),

              ],
            );
          } else if (snapshot.data is ErrorState) {

            return AppBar(
              title: Text('Error loading'),
            );

          } else{
            return CircularProgressIndicator();
          }
        } else {
          return AppBar();
        }
    });
  }
}
