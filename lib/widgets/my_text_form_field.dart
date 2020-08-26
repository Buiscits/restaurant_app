

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isEmail;
  final int minLines;
  final int maxLines;
  final String labelText;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isEmail,
    this.minLines,
    this.maxLines,
    this.labelText
  });

  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: EdgeInsets.all(8.0),

     child: TextFormField(
       decoration: InputDecoration(
         labelText: this.labelText,
         hintText: this.hintText,
         contentPadding: EdgeInsets.all(15.0),
         border: InputBorder.none,
         filled: true,
         fillColor: Colors.grey[200],
       ),

       obscureText: false,
       validator: validator,
       onSaved: onSaved,
       keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
       minLines: this.minLines,
       maxLines: this.maxLines,
     ),
   );
  }

  
}