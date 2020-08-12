

import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/checkout.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';

class CheckoutScreenViewModel extends ChangeNotifier {

  RemoteDataSource _apiResponse = RemoteDataSource();


  void checkout(Checkout checkout, Function completion) async {

    var data = {
      'table_number': checkout.tableNumber,
      'mprm_email': checkout.email,
      'mprm_first': checkout.name,
      'mprm_last': checkout.surname,
      'customer_note': checkout.customerNotes,
      'mprm_action': 'purchase',
      'mprm-gateway': 'manual',
    };

    var callback = () {

    };

    return _apiResponse.checkout(data, callback);
  }
}