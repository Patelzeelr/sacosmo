import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  BlackButton(this.label,this.onPressed);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: black,
        elevation: 10.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: size.width * 0.8,
          height: 42.0,
          child: Text(
            label,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Raleway'),
          ),
        ),
      ),
    );
  }
}