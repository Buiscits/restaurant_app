



import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';


class MenuScreenViewModel {
  RemoteDataSource _apiResponse = RemoteDataSource();

  Future<Result<dynamic>> getMenu() async {
    return _apiResponse.getMenu();
  }

  Future<Result<dynamic>> getCart() async {
    return _apiResponse.getCart();
  }


}