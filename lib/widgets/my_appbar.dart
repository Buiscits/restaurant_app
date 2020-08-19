

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/cart.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/my_app_bar_service.dart';
import 'package:resturant_website_app/views/cart_screen.dart';


class MyAppBar extends StatefulWidget implements PreferredSizeWidget {

  static MyAppBarState of(BuildContext context) => context.findAncestorStateOfType<MyAppBarState>();




  //static _MyAppBar of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<_StartupPageState>());

  MyAppBar({Key key}) : super(key: key);

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
              title: Text('title'),
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
                          ));
                    },
                  ),
                ),

              ],
            );
          } else if (snapshot.data is ErrorState) {
            return Text('error');
          } else{
            return CircularProgressIndicator();
          }
        } else {
          return AppBar();
        }
    }

    );

    return FutureBuilder(
      future: cartFuture,
      builder: (context, snapshot) {
        if (snapshot.data is SuccessState) {

          Cart cart = (snapshot.data as SuccessState).value;

          return AppBar(
            title: Text('title'),
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

                      setState(() {
                        cartFuture = _appBarService.getCart();
                      });

                      print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');

                    });
                  },
                ),
              ),

            ],
          );
        } else if (snapshot.data is ErrorState) {
          return Text('error');
        } else{
          return CircularProgressIndicator();
        }
      },

    );
  }

}


/*
class _MyAppBar extends State<MyAppBar> {

  MyAppBarService _appBarService = MyAppBarService();

  Future<Result<dynamic>> cartFuture;

  @override
  void initState() {
    super.initState();

    cartFuture = _appBarService.getCart();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: cartFuture,
      builder: (context, snapshot) {
        if (snapshot.data is SuccessState) {

          Cart cart = (snapshot.data as SuccessState).value;

          return AppBar(
            title: Text('title'),
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

                      setState(() {
                        cartFuture = _appBarService.getCart();
                      });

                      print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');

                    });
                  },
                ),
              ),

            ],
          );
        } else if (snapshot.data is ErrorState) {
          return Text('error');
        } else{
          return CircularProgressIndicator();
        }
      },

    );
  }

}

 */

/*
Widget MyAppBar(BuildContext context, String title, Cart cart) {

  MyAppBarService _appBarService = MyAppBarService();

  return FutureBuilder(
        future: _appBarService.getCart(),
        builder: (context, snapshot) {
          if (snapshot.data is SuccessState) {

            Cart cart = (snapshot.data as SuccessState).value;

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
          } else if (snapshot.data is ErrorState) {
            return Text('error');
          } else{
            return CircularProgressIndicator();
          }
        },

      );
}

 */

/*
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

 */