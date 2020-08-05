

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/view_models/category_screen_view_model.dart';

class CategoryScreen extends StatefulWidget {

  final Category category;

  CategoryScreen({Key key, @required this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _categoryScreenState(category);

}

class _categoryScreenState extends State<CategoryScreen> {

  CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();

  Category category;

  _categoryScreenState(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: FutureBuilder(
          future: model.getItemsInCategory(category.id),
          builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {

              CategoryItems items = (snapshot.data as SuccessState).value;
              return _itemsList(context, items);
            } else if (snapshot.data is ErrorState) {
              String errorMessage = (snapshot.data as ErrorState).msg;
              return Center(
                  child: Text(errorMessage)
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget _itemsList(BuildContext context, CategoryItems category) {
    List<Item> items = category.items;
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(2),
          child: Card(
              child: new InkWell(
                child: Center(
                  child: Text(items[index].name, style: TextStyle(fontSize: 20),),
                  heightFactor: 3,
                ),
                onTap: () {
                  //model.selectedCategoryIndex = index;
                  //Backdrop.of(context).fling();
                },

              )

          ),
        )
    );
  }

}