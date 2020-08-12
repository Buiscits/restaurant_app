

import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/checkout.dart';
import 'package:resturant_website_app/models/chekout_completed.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';

class CheckoutScreenViewModel extends ChangeNotifier {

  RemoteDataSource _apiResponse = RemoteDataSource();


  void checkout(Checkout checkout, Function completion) async {

    var result = _apiResponse.checkout(checkout.toJson()).then((value) {
      if (value is SuccessState) {
        CheckoutCompleted completedCheckout = (value as SuccessState).value;

        completion(completedCheckout);

      } else {
        completion(null);
      }
    }) ;


  }
}