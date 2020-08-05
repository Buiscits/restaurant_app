



import 'package:http/http.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/menu_client.dart';
import 'package:resturant_website_app/utils/request_type.dart';

class RemoteDataSource {

  RemoteDataSource._privateConstructor();
  static final RemoteDataSource _apiResponse = RemoteDataSource._privateConstructor();
  factory RemoteDataSource() => _apiResponse;

  MenuClient client = MenuClient(Client());

  void init() {

  }

  Future<Result> getMenu() async {
    try {
      final response = await client.request(requestType: RequestType.GET, path: "menu/cats");
      if (response.statusCode == 200) {
        return Result<Menu>.success(Menu.fromRawJson(response.body));
      } else {
        return Result.error('Failed to get menu json');
      }
    } catch (error) {
      return Result.error('Something went wrong when requesting Menu');
    }
  }

  Future<Result> getItemsInCategory(int id) async {
    try {
      final response = await client.request(requestType: RequestType.GET, path: "menu/items/?cat_id=$id",);
      if (response.statusCode == 200) {
        return Result<CategoryItems>.success(CategoryItems.fromRawJson(response.body));
      } else {
        return Result.error('Failed to get menu json');
      }
    } catch (error) {
      return Result.error('Something went wrong when requesting Menu');
    }
  }

}