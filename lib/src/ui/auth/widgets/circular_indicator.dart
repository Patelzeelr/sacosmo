import 'package:flutter/material.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';

class CircularIndicator extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(color: black),
          SizedBox(height: 20.0),
          Text(loading)
        ],
      ),
    );
  }

}