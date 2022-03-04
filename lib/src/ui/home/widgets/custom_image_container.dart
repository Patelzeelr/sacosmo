import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/textdecorate_constant.dart';
import 'package:cosmo_beauty/src/base/constants/image_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImageContainer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 100,
      height: size.height * 0.6,
      // color: Colors.orange,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(homeMain),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60.0)
        ),
      ),

    );
  }

}