
import 'package:flutter/cupertino.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';
import 'package:resturant_website_app/services/resturant_data.dart';
import 'package:resturant_website_app/services/service_locator.dart';

class BackdropScreenViewModel extends ChangeNotifier {

  final ResturantData _dataService = serviceLocator<ResturantData>();

  RemoteDataSource _apiResponse = RemoteDataSource();

  List<String> _categories = [];

  int _selectedCategoryIndex = -1;



  Future<Result<dynamic>> getMenu() async {
    return _apiResponse.getMenu();
  }

 List<String> get categories {
    return _categories;
 }

 int get selectedCategoryIndex {
    return _selectedCategoryIndex;
 }

set selectedCategoryIndex(int index) {

  _selectedCategoryIndex = index;
  notifyListeners();
}

}