

import 'package:get_it/get_it.dart';

import 'package:resturant_website_app/view_models/cart_screen_view_model.dart';
import 'package:resturant_website_app/view_models/category_screen_view_model.dart';
import 'package:resturant_website_app/view_models/menu_screen_view_model.dart';

GetIt serviceLocator = GetIt.instance;

void setUpServiceLocator() {

  serviceLocator.registerFactory<MenuScreenViewModel>(() => MenuScreenViewModel());
  serviceLocator.registerFactory<CategoryScreenViewModel>(() => CategoryScreenViewModel());
  serviceLocator.registerFactory<CartScreenViewModel>(() => CartScreenViewModel());
}
