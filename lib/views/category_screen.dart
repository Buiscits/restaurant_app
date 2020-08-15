

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/view_models/category_screen_view_model.dart';

import 'cart_screen.dart';

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
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: Icon(Icons.shopping_basket),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreen()
                    ));
              },
            ),
          )
        ],
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

                  final snackBar = SnackBar(content: Text('${item.name} added to basket'));

                  var completion = () {
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(snackBar);
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