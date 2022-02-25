import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/textdecorate_constant.dart';
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/homeWallPaper.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: kBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0,right: 10.0),
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.search,color: black),
            onPressed: () {  },
          ),
        ),
      ),
    );
  }

}