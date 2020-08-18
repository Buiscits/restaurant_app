

import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';

class MyAppBarService {

  RemoteDataSource _apiResponse = RemoteDataSource();

  Future<Result<dynamic>> getCart() async {
    return _apiResponse.getCart();
  }
}