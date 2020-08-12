

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      child: Column(
        children: <Widget>[
          Text('Table Number: ${model.tableNumber}'),
          Text('Date: ${model.date}'),
          Text('Total: £${model.subtotal.toStringAsFixed(2)}'),
          Text('Order Number: ${model.orderNumber}'),

        ],
      ),
    );
  }

  Widget _buildModelContentsNull(BuildContext context) {
    return Text('Sorry not able to place order');
  }


}