

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

      body: Text('comple')
    );
  }


}