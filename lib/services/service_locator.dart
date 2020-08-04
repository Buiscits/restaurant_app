

import 'package:get_it/get_it.dart';
import 'package:resturant_website_app/services/resturant_data.dart';
import 'package:resturant_website_app/services/resturant_data_fake.dart';
import 'package:resturant_website_app/view_models/backdrop_screen_view_model.dart';

GetIt serviceLocator = GetIt.instance;

void setUpServiceLocator() {
  serviceLocator.registerLazySingleton<ResturantData>(() => ResturantDataFake());

  serviceLocator.registerFactory<BackdropScreenViewModel>(() => BackdropScreenViewModel());
}
