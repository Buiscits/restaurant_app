



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

  // MAYBE MOVE TO ANOTHER CLASS TO MAKE MORE ABSTRACT
  int selectedCategoryIndex = -1;

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

}