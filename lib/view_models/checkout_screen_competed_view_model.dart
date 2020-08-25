

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:resturant_website_app/models/checkout.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';

class CheckoutScreenCompletedViewModel {

  RemoteDataSource _apiResponse = RemoteDataSource();

  Future<Result> checkout(Checkout checkout) async {

    return _apiResponse.checkout(checkout.toJson());
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    var formatter = DateFormat('EEEE, d MMMM H:m');

    return formatter.format(dateTime);
  }

}