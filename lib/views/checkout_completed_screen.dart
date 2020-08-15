

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/checkout.dart';
import 'package:resturant_website_app/models/chekout_completed.dart';

class CheckoutCompletedScreen extends StatelessWidget {

  CheckoutCompleted model;
  CheckoutCompletedScreen({this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('You Order has been placed'),
      ),

      body: model != null ? _buildModelContents(context)
                          : _buildModelContentsNull(context)
    );
  }

  Widget _buildModelContents(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Table Number: ${model.tableNumber}', style: TextStyle(fontSize: 20),),
            Text('Date: ${model.date}'),
            Text('Total: £${model.subtotal.toStringAsFixed(2)}'),
            Text('Order Number: ${model.orderNumber}'),

            Flexible(
              child: ListView.builder(
                itemCount: model.items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: _buildItemCard(context, model.items[index]),
                  );
                },
              ),
            )
          ],
          ),
        ),
      );
  }

  Widget _buildModelContentsNull(BuildContext context) {
    return Text('Sorry not able to place order');
  }

  Widget _buildItemCard(BuildContext context, Item item) {
    return ListTile(
        title: Text('${item.name}')
    );
  }


}