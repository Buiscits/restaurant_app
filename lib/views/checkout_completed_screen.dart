

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/categories.dart';
import 'package:resturant_website_app/models/checkout.dart';
import 'package:resturant_website_app/models/chekout_completed.dart';
import 'package:resturant_website_app/models/result.dart';
import 'package:resturant_website_app/view_models/checkout_screen_competed_view_model.dart';

class CheckoutCompletedScreen extends StatefulWidget {
  
  final checkout;
  
  CheckoutCompletedScreen({this.checkout});
  
  @override
  State<StatefulWidget> createState() => _CheckoutCompletedScreenState();
  
}


class _CheckoutCompletedScreenState extends State<CheckoutCompletedScreen> {

  CheckoutScreenCompletedViewModel model = CheckoutScreenCompletedViewModel();
  
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        title: Text('Success'),
      ),
      
      body: FutureBuilder(
        future: model.checkout(widget.checkout),
        builder: (context, snapshot) {
          if (snapshot.data is SuccessState) {

            CheckoutCompleted checkoutCompleted = (snapshot.data as SuccessState).value;


            return _buildCheckoutCompleted(context, checkoutCompleted);

          } else if (snapshot.data is ErrorState) {
              return Center(
                child: Text('Sorry your order could not be placed'),
              );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildCheckoutCompleted(BuildContext context, CheckoutCompleted checkoutCompleted) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Order Number: ${checkoutCompleted.orderNumber}', style: TextStyle(fontSize: 20),),
            Text('Total: £${checkoutCompleted.subtotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 20),),
            Text('Table Number: ${checkoutCompleted.tableNumber}', style: TextStyle(fontSize: 20),),
            //Text('${model.date}', style: TextStyle(fontSize: 20),),
            Text('${model.formatDate(checkoutCompleted.date)}', style: TextStyle(fontSize: 20),),

            Flexible(
              child: ListView.builder(
                itemCount: checkoutCompleted.items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: _buildItemCard(context, checkoutCompleted.items[index]),
                  );
                },
              ),
            )
          ],
          ),
        ),
      );
  }

  Widget _buildItemCard(BuildContext context, Item item) {
    return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Text('${item.name}', style: TextStyle(fontWeight: FontWeight.bold),),
            Text('£ ${item.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 20.0),)

          ]
        ),
      subtitle: item.quantity == 1 ? Text('1 Item', style: TextStyle(color: Colors.green),) : Text('${item.quantity} items', style: TextStyle(color: Colors.green),),
    );
  }


}