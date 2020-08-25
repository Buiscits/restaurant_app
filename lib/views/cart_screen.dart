

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

  Widget _itemsList(BuildContext context, List<Item> items) {

    return Column(
      children: <Widget>[

        Flexible(
          child: Padding(
            padding: EdgeInsets.only(top: 2),
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Center(
                      child: _itemCard(context, items[index]),
                    )
                )
            ),
          ),
        ),


        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: RaisedButton(
            color: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            child: Text('Proceed to checkout', style: TextStyle(color: Colors.white),),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                '${item.name}',
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0, fontWeight: FontWeight.bold),)
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Padding(
                  padding: EdgeInsets.only(left: 20,),
                  child: Text('£${item.price.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22.0),)
              ),

              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        child: Text('Add'),

                        onPressed: () {

                          var completion = (bool success) {
                            if (success) {
                              setState(() {
                                this._appBarKey.currentState.loadAppBarData();

                                Scaffold.of(context).hideCurrentSnackBar();
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Added ${item.name}'), duration: Duration(seconds: 1),));
                              });
                            }
                          };

                          model.changeItemQuantity(item.itemId, item.quantity + 1, completion);

                        }

                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    child: RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        child: Text('Remove', style: TextStyle(color: Colors.white),),

                        onPressed: () {

                          var completion = (bool success) {
                            if (success) {
                              this._appBarKey.currentState.loadAppBarData();

                              Scaffold.of(context).hideCurrentSnackBar();
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Removed ${item.name}'), duration: Duration(seconds: 1),));
                            }
                          };

                          if (item.quantity == 1) {
                            model.deleteItem(item.itemId, completion);
                          } else {
                            model.changeItemQuantity(item.itemId, item.quantity - 1, completion);
                          }

                        }

                    ),
                  )
                ],
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              _itemQuantityText(context, item)

            ],
          )
        

        ],
      ),
    );
  }

  Widget _itemQuantityText(BuildContext context, Item item) {

    String quantityText = item.quantity == 1 ? '1 Item in cart' : '${item.quantity} items in cart';

    return Padding(
      padding: EdgeInsets.only(right: 10, bottom: 10),
      child: Text(quantityText, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
    );

  }

}