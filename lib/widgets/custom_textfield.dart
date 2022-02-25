import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(this.labelText,this.onChange);

  String labelText;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: grey,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: darkGrey)
        ),
        focusColor: Colors.red,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: grey
        )
      ),
      onChanged: onChange,
      style: const TextStyle(color: black,fontWeight: FontWeight.bold),
    );
  }

}