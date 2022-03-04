import 'package:cosmo_beauty/src/ui/auth/screens/sizeConfig.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/strings_constant.dart';


class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "SA COSMO",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: Color(0xFF8f7d5e),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: kTextBlackBoldStyle,
        ),
        Spacer(flex: 2),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
