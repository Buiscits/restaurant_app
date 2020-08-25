

import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/view_models/menu_screen_view_model.dart';
import 'package:resturant_website_app/views/category_screen.dart';
import 'package:resturant_website_app/widgets/my_appbar.dart';

class MenuScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  final _appBarKey = GlobalKey<MyAppBarState>();

  MenuScreenViewModel model = serviceLocator<MenuScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(key: _appBarKey, title: 'Menu',),

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
                        )).then((value) {
                          this._appBarKey.currentState.loadAppBarData();
                    });
                  },
                  child: Card(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[


                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 20),
                                child: Text(model.categories[index].name,style: TextStyle(fontSize: 24),),
                              )
                            ),

                            Container(
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(model.categories[index].img)
                                )
                              ),
                            )

                            /*
                            AspectRatio(
                              aspectRatio: 3/2,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: _categoryImage(context, model.categories[index].img),
                                )
                            )

                             */



                          ]
                      )
                  ));
            })
        ));
  }

  Widget _categoryImage(BuildContext context, dynamic imgString) {
    if (imgString != null) {
      return Image.network(imgString, fit: BoxFit.fill,);
    } else {
      return SizedBox.shrink();
    }
  }

}