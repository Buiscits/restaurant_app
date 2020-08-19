

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/view_models/category_screen_view_model.dart';
import 'package:resturant_website_app/widgets/my_appbar.dart';

class CategoryScreen extends StatefulWidget {

  final Category category;

  CategoryScreen({@required this.category});

  @override
  State<StatefulWidget> createState() => _categoryScreenState();
}

class _categoryScreenState extends State<CategoryScreen> {

  CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();

  final _appBarKey = GlobalKey<MyAppBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(key: _appBarKey, title: widget.category.name,),
      body: FutureBuilder(
          future: model.getItemsInCategory(widget.category.id),
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
          child: Center(
            child: _itemCard(context, items[index]),
          )
        )
    );
  }

  Widget _itemCard(BuildContext context, Item item) {
    return Card(
      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: <Widget>[
                Text(item.name),
              ],
            ),
          ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('£ ${item.price.toStringAsFixed(2)}'),
            //Text('x2'),
          ],
        ),


        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {

                  final snackBar = SnackBar(content: Text('${item.name} added to basket'), duration: Duration(seconds: 1),);

                  var completion = () {
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(snackBar);

                    this._appBarKey.currentState.loadAppBarData();
                  };

                  model.addItemToCart(item.itemId, completion);
                },
              ),

              IconButton(
                icon: Icon(Icons.remove),
              ),

            ],
          ),
        )
      ],
      ),
    );
  }

}