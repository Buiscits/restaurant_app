

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CheckoutScreenCompletedViewModel {

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    //var formatter = DateFormat('MMMM EEEE d H:m');
    var formatter = DateFormat('EEEE, d MMMM H:m');

    return formatter.format(dateTime);
  }

}