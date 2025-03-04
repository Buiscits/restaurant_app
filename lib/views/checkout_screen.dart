

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_website_app/models/checkout.dart';
import 'package:resturant_website_app/models/chekout_completed.dart';
import 'package:resturant_website_app/models/saved_user_data.dart';
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

  int tableNumber;
  String name = '';
  String surname = '';
  String email = '';
  String customerNotes = '';

  @override
  void initState() {
    super.initState();

    var savedData = model.loadSavedUserData().then((value) {

      setState(() {
        value.name == '' ? this.name = '' : this.name = value.name;
        value.surname == '' ? this.surname = '' : this.surname = value.surname;
        value.email == '' ? this.email = '' : this.email = value.email;
      });

    });
  }

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

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: DropdownButtonFormField<int>(
                hint: Text('Table Number'),
                onChanged: (value) {
                  this.tableNumber = value;
                },

                items: List.generate(100, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text((index + 1).toString()),
                    ),
                  );
                }),

                validator: (value) {
                  return value == null ? 'Please select a table number' : null;
                },

                onSaved: (value) {
                  this.tableNumber = value;
                },
              ),
            ),

            Container(
              child: Row(
                children: <Widget>[

                  Container(
                    width: halfScreenWidth,
                    child: MyTextFormField(
                      labelText: this.name,
                      hintText: 'First Name',
                      isEmail: false,
                      validator: (String value) {
                        if (this.name != '') {
                          return null;
                        } else if (value == '') {
                          return 'Please enter your name';
                        } else {
                          return null;
                        }

                        return null;
                      },

                      onSaved: (String value) {
                        if (value != '') {
                          this.name = value;
                        }
                      },
                    ),
                  ),

                  Container(
                    width: halfScreenWidth,
                    child: MyTextFormField(
                      labelText: this.surname,
                      hintText: 'Surname Name',
                      isEmail: false,
                      validator: (String value) {
                        return null;
                      },
                      onSaved: (String value) {
                        if (value != '') {
                          this.surname = value;
                        }
                      },
                    ),
                  )
              ])
            ),

            MyTextFormField(
              labelText: this.email,
              hintText: 'Email',
              minLines: 1,
              isEmail: true,
              validator: (String value) {

                if (value == '' && this.email != '') {
                  return null;
                } else if (value == '') {
                  return 'Please enter your email';
                } else if (!validator.isEmail(value)) {
                  return 'Please enter a valid email';
                } else {
                  return null;
                }

              },

              onSaved: (String value) {
                if (value != '') {
                  this.email = value;
                }
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
              padding: EdgeInsets.only(right: 20, left: 20),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  child: Text('Place Order', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      var saveUserData = SavedUserData(name: this.name, surname: this.surname, email: this.email);
                      model.saveToDefaults(saveUserData);

                      var checkout = Checkout(customerNotes: this.customerNotes,
                          email: this.email,
                          name: this.name,
                          surname: this.surname,
                          tableNumber: '${this.tableNumber}');

                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>
                              CheckoutCompletedScreen(checkout: checkout)));

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