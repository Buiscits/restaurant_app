
import 'package:resturant_website_app/services/resturant_data.dart';

class ResturantDataFake implements ResturantData {

  @override
  Future<List<String>> getCategories() async {
    List<String> list = [];

    list.add('Mains');
    list.add('Sides');
    list.add('Drinks');
    list.add('Desserts');

    return list;
  }

}