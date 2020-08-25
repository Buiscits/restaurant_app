

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

    var dateFormatter = DateFormat('EEEE, d MMMM H:');
    String formattedDate = dateFormatter.format(dateTime);

    var minuteFormatter = DateFormat('m');
    String formattedMinute = minuteFormatter.format(dateTime);

    if (formattedMinute.length == 1) {
      formattedDate += '0${formattedMinute}';
    } else {
      formattedDate += formattedMinute;
    }

    return formattedDate;
  }

}