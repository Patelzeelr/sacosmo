import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteIconButton extends StatelessWidget{
  FavouriteIconButton(this.onPressed);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.favorite_border)
    );
  }
}

