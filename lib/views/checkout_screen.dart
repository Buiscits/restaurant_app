

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/checkout.dart';
import 'package:resturant_website_app/models/chekout_completed.dart';
import 'package:resturant_website_app/view_models/checkout_screen_view_model.dart';
import 'package:resturant_website_app/views/checkout_completed_screen.dart';
import 'package:resturant_website_app/widgets/my_text_form_field.dart';
import 'package:validators/validators.dart' as validator;

class CheckoutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _checkoutScreenState();
}

class _checkoutScreenState extends State<CheckoutScreen> {

  final _formKey = GlobalKey<FormState>();

  var model = CheckoutScreenViewModel();

  String tableNumber = '';
  String name = '';
  String surname = '';
  String email = '';
  String customerNotes = '';


  @override
  Widget build(BuildContext context) {

    final halfScreenWidth = MediaQuery.of(context).size.width / 2.0;

    return Scaffold(

      appBar: AppBar(
        title: Text('Checkout'),
      ),

      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[

            MyTextFormField(
              hintText: 'Table Number',
              isEmail: false,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your table number';
                }

                return null;
              },
              onSaved: (String value) {
                this.tableNumber = value;
              },
            ),

            Container(
              child: Row(
                children: <Widget>[

                  Container(
                    width: halfScreenWidth,
                    child: MyTextFormField(
                      hintText: 'First Name',
                      isEmail: false,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }

                        return null;
                      },
                      onSaved: (String value) {
                        this.name = value;
                      },
                    ),
                  ),

                  Container(
                    width: halfScreenWidth,
                    child: MyTextFormField(
                      hintText: 'Surname Name',
                      isEmail: false,
                      validator: (String value) {

                        return null;
                      },
                      onSaved: (String value) {
                        this.surname = value;
                      },
                    ),
                  )
              ])
            ),

            MyTextFormField(
              hintText: 'Email',
              minLines: 1,
              isEmail: true,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your email';
                } else if (!validator.isEmail(value)) {
                  return 'Please enter a valid email';
                }

                return null;
              },

              onSaved: (String value) {
                this.email = value;
              },
            ),

            MyTextFormField(
              hintText: 'Customer Note',
              minLines: 2,
              maxLines: 5,
              isEmail: true,
              validator: (String value) {
                return null;
              },

              onSaved: (String value) {
                this.customerNotes = value;
              },
            ),

            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Place Order'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      var checkout = Checkout(customerNotes: this.customerNotes,
                          email: this.email,
                          name: this.name,
                          surname: this.surname,
                          tableNumber: this.tableNumber);

                      var completion = (CheckoutCompleted completedCheckout) {
                        if (completedCheckout != null) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  CheckoutCompletedScreen(model: completedCheckout)));
                        } else {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  CheckoutCompletedScreen(model: null)));
                        }
                      };

                      model.checkout(checkout, completion);
                    }
                  },
                ),
              ),
            )

        ]),
      ),

    );
  }

}