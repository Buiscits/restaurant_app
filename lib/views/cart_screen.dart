

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/cart.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/view_models/cart_screen_view_model.dart';

class CartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _cartScreenState();
}

class _cartScreenState extends State<CartScreen> {

  CartScreenViewModel model = serviceLocator<CartScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket'),
      ),
      body: FutureBuilder(
        future: model.getCart(),
        builder: (context, snapshot) {
          if (snapshot.data is SuccessState) {

            Cart cart = (snapshot.data as SuccessState).value;

            return cart.items.isEmpty ? Center(child: Text('The cart is empty'))
                                      : _itemsList(context, cart);

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

  Widget _itemsList(BuildContext context, Cart cart) {
    List<Item> items = cart.items;
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Container(
            padding: EdgeInsets.all(2),
            child: Center(
              child: _itemCard(context, items[index]),
            )
        )
    );
  }

  Widget _itemCard(BuildContext context, Item item) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Column(
            children: <Widget>[
              Text(item.name),
              Text('Description')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Price'),
              Text('x2'),
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
                    //model.addItemToCart(item.itemId);
                  },
                ),

                IconButton(
                  icon: Icon(Icons.remove),
                ),

              ],
            ),
          )





        ],
      ),
    );
  }

}