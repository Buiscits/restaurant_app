

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/checkout.dart';

class CheckoutCompletedScreen extends StatelessWidget {

  Checkout model;
  CheckoutCompletedScreen({this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('You Order has been placed'),
      ),

      body: ListView.builder(
        itemCount: model.elements().length,
        itemBuilder: (context, index) {
          return Text(this.model.elements()[index]);
        },

      ),
    );
  }


}