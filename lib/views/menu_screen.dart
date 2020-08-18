


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/cart.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/view_models/menu_screen_view_model.dart';
import 'package:resturant_website_app/views/cart_screen.dart';
import 'package:resturant_website_app/views/category_screen.dart';
import 'package:resturant_website_app/widgets/my_appbar.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuScreenState();

}

class _MenuScreenState extends State<MenuScreen> {

  MenuScreenViewModel model = serviceLocator<MenuScreenViewModel>();

  int totalItemQuantity = 0;
  double totalItemPrice = 0.0;

  void waitForCart() async {
    var result = await model.getCart().then((value) => () {
      if (value is SuccessState) {
        Cart cart = ((value as SuccessState).value) as Cart;
        setState(() {
          this.totalItemQuantity = cart.totalItemCount;
          this.totalItemPrice = cart.totalItemPrice;
        });

      } else {
        print('errro');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //waitForCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),

      body: FutureBuilder(
          future: model.getMenu(),
          builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {
              Menu menu = (snapshot.data as SuccessState).value;
              return _menuGrid(context, menu);
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

  /*
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: model.getMenu(),
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.data is SuccessState) {
            Menu menu = (snapshot.data as SuccessState).value;
            return _menuGrid(context, menu);
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
        });
  }

   */


  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(

                child: Row(
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text('£ ${this.totalItemPrice}'),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text('(${this.totalItemQuantity})'),
                    ),

                    Icon(Icons.shopping_basket),



                  ],
                ),

                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartScreen()
                      )).then((value) => () {
                        //waitForCart();
                  });
                },
              ),
            ),

          ],
        ),

        body: FutureBuilder(
            future: model.getMenu(),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                Menu menu = (snapshot.data as SuccessState).value;
                return _menuGrid(context, menu);
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

   */



  Widget _menuGrid(BuildContext context, Menu model) {
    return Center(
        child: GridView.count(
            crossAxisCount: 2,
            children:List.generate(model.categories.length, (index) {

              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(category: model.categories[index],)
                        ));
                  },
                  child: Card(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[


                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 10),
                                child: Text(model.categories[index].name,style: TextStyle(fontSize: 24),),
                              )
                            ),

                            AspectRatio(
                              aspectRatio: 3/2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: _categoryImage(context, model.categories[index].img),
                                )
                            )

                            )

                          ]
                      )
                  ));
            })
        ));
  }

  Widget _categoryImage(BuildContext context, dynamic imgString) {
    if (imgString != null) {
      return Image.network(imgString);
    } else {
      return SizedBox.shrink();
    }
  }

}