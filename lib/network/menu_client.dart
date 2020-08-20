



import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:flutter/foundation.dart';
import 'package:resturant_website_app/utils/nothing.dart';
import 'package:resturant_website_app/utils/request_type.dart';
import 'package:resturant_website_app/utils/request_type_exception.dart';

class MenuClient {

  static const String _baseUrl = 'https://wpdemo.secondscreenldn.com/wordpress/index.php/wp-json/mprm/v1';
  final Client _client;

  MenuClient(this._client);

  Future<Response> request({@required RequestType requestType, String cookie, @required String path, dynamic parameter = Nothing}) async {
    switch(requestType) {
      case RequestType.GET:
        return cookie != '' ? _client.get("$_baseUrl/$path", headers: {'cookie': cookie}) : _client.get("$_baseUrl/$path");
      case RequestType.POST:
        return _client.post("$_baseUrl/$path",
            headers: {"Content-Type": "application/json", "cookie": cookie}, body: json.encode(parameter));
      case RequestType.FORM_POST:
        return _client.post("$_baseUrl/$path",
            headers: {"Content-Type": "application/x-www-form-urlencoded", "cookie": cookie}, body: parameter);
      case RequestType.DELETE:
        return _client.delete("$_baseUrl/$path");
      default:
        return throw RequestTypeNotFoundException("The HTTP request mentioned is not found");
    }
  }


}