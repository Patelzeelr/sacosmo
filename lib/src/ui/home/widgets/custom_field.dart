import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String labText;
  FormFieldValidator onCheck;

  CustomField(this.labText,this.controller,this.onCheck);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onCheck,
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
      ),
    );
  }
}