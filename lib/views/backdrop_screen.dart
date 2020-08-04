



import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/network/remote_data_source.dart';
import 'package:resturant_website_app/services/service_locator.dart';
import 'package:resturant_website_app/view_models/backdrop_screen_view_model.dart';



class BackdropScreen extends StatefulWidget {

  @override
  _BackdropScreenState createState() => _BackdropScreenState();

}

class _BackdropScreenState extends State<BackdropScreen> {

  BackdropScreenViewModel model = serviceLocator<BackdropScreenViewModel>();


  Future<Result> menu;

  @override
  void initState() {
    super.initState();
    menu = model.getMenu();
  }

  @override
  Widget build(BuildContext context) {

    return BackdropScaffold(
      appBar: BackdropAppBar(
        title: Text('Menu'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: Icon(Icons.shopping_basket),
            ),
          )
        ],
      ),
      stickyFrontLayer: false,

      frontLayer: FutureBuilder(
        future: menu,
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {

          if (snapshot.data is SuccessState) {
            Menu menu = (snapshot.data as SuccessState).value;
            return _frontLayerAllCategoriesWidget(context, menu);

          } else if (snapshot.data is ErrorState) {
            String errorMessage = (snapshot.data as ErrorState).msg;
            return Center(
              child: Text(errorMessage)
            );

          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      backLayer: FutureBuilder(
        future: menu,
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.data is SuccessState) {
            Menu menu = (snapshot.data as SuccessState).value;
            return _backLayer(context, menu);
          } else if (snapshot.data is ErrorState) {
            String errorMessage = (snapshot.data as ErrorState).msg;
            return Center(
                child: Text(errorMessage)
            );
          } else {
            return CircularProgressIndicator();
          }
        }),

      subHeader: Padding(
        padding: EdgeInsets.all(20),
        child: Text('Menu'),
      )

    );
  }

  Widget _frontLayerAllCategoriesWidget(BuildContext context, Menu model) {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        children:List.generate(model.categories.length, (index) {
          return GestureDetector(
              onTap: () {
                Backdrop.of(context).revealBackLayer();
              },
              child: Card(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(model.categories[index].name,style: TextStyle(fontSize: 20),),
                    )
                  ]
                )
            ));
          })
    ));
  }

  Widget _backLayer(BuildContext context, Menu model) {
    List<Category> categories = model.categories;
    return ListView.builder(
        itemCount: model.categories.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(2),
          child: Card(
              child: new InkWell(
                child: Center(
                  child: Text(categories[index].name, style: TextStyle(fontSize: 20),),
                  heightFactor: 3,
                ),
                onTap: () {
                  //model.selectedCategoryIndex = index;
                  Backdrop.of(context).fling();
                },

              )

          ),
        )
    );
  }
    /*

        BackdropScaffold(
          appBar: BackdropAppBar(
            title: Text('Menu'),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  child: Icon(Icons.shopping_basket),
                ),
              )
            ],
            ),
          stickyFrontLayer: true,
          frontLayer: _frontLayerAllCategoriesWidget(context, model.categories.length),
          backLayer: ListView.builder(
            itemCount: model.categories.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(2),
                child: Card(
                  child: new InkWell(
                      child: Center(
                        child: Text(model.categories[index], style: TextStyle(fontSize: 20),),
                        heightFactor: 3,
                      ),
                      onTap: () {
                        model.selectedCategoryIndex = index;
                        Backdrop.of(context).fling();
                      },

                  )

                ),
              )
          ),
          subHeader: Padding(
            padding: EdgeInsets.all(10),
            child: model.selectedCategoryIndex == -1
                ? Text('Menu', style: TextStyle(fontSize: 20))
                : Text(model.categories[model.selectedCategoryIndex], style: TextStyle(fontSize: 20)),
          )

          ),
        ),
      ));
  }

  Widget _frontLayerAllCategoriesWidget(BuildContext context, int itemCount) {
    return Center(
      child: FutureBuilder(
        future: ,
      ),
    );




      GridView.count(
        crossAxisCount: 2,
        children:List.generate(itemCount, (index) {
          return Card(
            child: Column(
              children: <Widget>[

                Center(
                  child: Text('Name'),
                ),

                Center(
                  child: Text('Price'),
                ),

                RaisedButton(
                  color: Colors.blue,
                  child: Text('Add', style: TextStyle(color: Colors.black),),
                  onPressed: () {

                  },
                )
              ],
            ),
          );
        })
    );
  }
  */

}

