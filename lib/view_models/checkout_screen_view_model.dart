

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/checkout.dart';
import 'package:resturant_website_app/models/chekout_completed.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/models/saved_user_data.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutScreenViewModel {

  static final userDataDefaultsKey = 'saved_user_data';

  void saveToDefaults(SavedUserData userData) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(CheckoutScreenViewModel.userDataDefaultsKey, jsonEncode(userData.toJson()));
  }

  Future<SavedUserData> loadSavedUserData() async {
    var prefs = await SharedPreferences.getInstance();
    return SavedUserData.fromJson(jsonDecode(prefs.getString(CheckoutScreenViewModel.userDataDefaultsKey)));
  }

}