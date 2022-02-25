import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget{
  SocialMediaButton(this.color,this.socialIcon,this.iconColor,this.onPressed);

  final Color color;
  final IconData socialIcon;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    /*Size size = MediaQuery.of(context).size;
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(20.0),
      child: MaterialButton(
        color: color,
        onPressed: onPressed,
        minWidth: size.width * 0.4,
        height: 42.0,
        child: Icon(socialIcon,color: iconColor)
      ),
    );*/
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: size.width * 0.4,
          height: 42.0,
          child: Icon(socialIcon,color: iconColor)
        ),
      ),
    );
  }

}