

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/widgets/my_text_form_field.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _checkoutScreenState();
}

class _checkoutScreenState extends State<CheckoutScreen> {

  final _formKey = GlobalKey<FormState>();

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
                        return null;
                      },
                      onSaved: (String value) {
                        return null;
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
                        return null;
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
                }

                return null;
              },
              onSaved: (String value) {

              },
            ),

            MyTextFormField(
              hintText: 'Customer Note',
              minLines: 2,
              maxLines: 5,
              isEmail: true,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your email';
                }

                return null;
              },
              onSaved: (String value) {

              },
            ),

            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Place Order'),
                  onPressed: () {

                  },
                ),
              ),
            )





        ]),
      ),

    );
  }

}