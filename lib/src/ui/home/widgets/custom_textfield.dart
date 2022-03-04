import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(this.labelText,this.controller,this.onChange,this.textShow);

  String labelText;
  final TextEditingController controller;
  final Function(String)? onChange;
  final bool textShow;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: grey,
      obscureText: textShow,
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
      controller: controller,
      onChanged: onChange,
      style: const TextStyle(color: black,fontWeight: FontWeight.bold),
    );
  }

}