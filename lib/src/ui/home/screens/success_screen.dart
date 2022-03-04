import 'package:cosmo_beauty/src/ui/home/screens/bottom_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_black_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/strings_constant.dart';

class SuccessScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/success.png'),height: size.height * 0.3),
            Text('Thanks For Shopping',style: kTextBlackBoldStyle,),
            BlackButton('Continue Shopping', (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => BottomScreen(),
              ));
            })
          ],
        ),
      ),
    );
  }

}