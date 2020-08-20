

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/cart.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/checkout.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/view_models/cart_screen_view_model.dart';
import 'package:resturant_website_app/views/checkout_screen.dart';
import 'package:resturant_website_app/widgets/my_appbar.dart';

class CartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _cartScreenState();
}

class _cartScreenState extends State<CartScreen> {

  final _appBarKey = GlobalKey<MyAppBarState>();

  CartScreenViewModel model = serviceLocator<CartScreenViewModel>();

  @override
  void initState() {
    super.initState();
    model.getCart();
  }

  @override
  void dispose() {
    super.dispose();
    model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(key: this._appBarKey, title: 'Cart',),

      body: StreamBuilder(
        stream: model.streamController.stream,
        builder: (context, snapshot) {

          if (snapshot.data is SuccessState) {

            List<Item> items = ((snapshot.data as SuccessState).value as Cart).items;

            if (items.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Expanded(
                      child: _itemsList(context, items),
                    ),

                  ],
                ),
              );
            } else {
              return Center(
                child: Text('The cart is empty'),
              );
            }

          } else if (snapshot.data is ErrorState) {

            String errorMessage = (snapshot.data as ErrorState).msg;
            return Center(
                child: Text(errorMessage)
            );

          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        },
      ),
    );
  }
      /*
      body: FutureBuilder(
        future: cart,
        builder: (context, snapshot) {
          if (snapshot.data is SuccessState) {

            List<Item> items = ((snapshot.data as SuccessState).value as Cart).items;

            if (items.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Expanded(
                      child: _itemsList(context, items),
                    ),

                  ],
                ),
              );
            } else {
              return Center(
                child: Text('The cart is empty'),
              );
            }

          } else if (snapshot.data is ErrorState) {

            String errorMessage = (snapshot.data as ErrorState).msg;
            return Center(
                child: Text(errorMessage)
            );
            
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },

       */

  Widget _itemsList(BuildContext context, List<Item> items) {

    return Column(
      children: <Widget>[

        Expanded(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(2),
                  child: Center(
                    child: _itemCard(context, items[index]),
                  )
              )
          ),
        ),


        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: RaisedButton(
            child: Text('Proceed to checkout'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutScreen()
                  )
              );
            },
          ),
        )
      ],
    );
  }

  Widget _itemCard(BuildContext context, Item item) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: <Widget>[
                Text(item.name),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('£ ' + '${item.price.toStringAsFixed(2)}'),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('(${item.quantity})'),
              )
            ],
          ),


          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {

                    var completion = (bool success) {
                      if (success) {
                        setState(() {
                          this._appBarKey.currentState.loadAppBarData();

                          Scaffold.of(context).hideCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Added item'), duration: Duration(seconds: 1),));
                        });
                      }
                    };

                    model.changeItemQuantity(item.itemId, item.quantity + 1, completion);
                    //model.addItemToCart(item.itemId, completion);
                  },
                ),

                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {

                    var completion = (bool success) {
                      if (success) {
                        this._appBarKey.currentState.loadAppBarData();

                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Removed item'), duration: Duration(seconds: 1),));
                      }
                    };

                    if (item.quantity == 1) {

                    } else {
                      model.changeItemQuantity(item.itemId, item.quantity - 1, completion);
                    }

                  },

                ),

              ],
            ),
          )
        ],
      ),
    );
  }

}