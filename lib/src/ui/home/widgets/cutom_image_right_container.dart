import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/image_constant.dart';
import 'package:flutter/material.dart';

class CustomImageRightContainer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          color: mainContainer,
          width: size.width * 100,
          height: size.height * 0.6,
        ),
        Container(
          width: size.width * 100,
          height: size.height * 0.6,
          // color: Colors.orange,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(brandImage),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(60.0)
            ),
          ),
        ),
      ],
    );
  }

}