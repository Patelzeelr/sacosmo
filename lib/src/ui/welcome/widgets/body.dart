import 'package:flutter/material.dart';

import '../../../base/constants/image_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../../auth/screens/login_screen.dart';
import '../../auth/screens/sizeConfig.dart';
import '../../home/widgets/custom_black_button.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": onboardTextOne,
      "image": onboardOne
    },
    {
      "text": onboardTextTwo,
      "image": onboardTwo
    },
    {
      "text": onboardTextThree,
      "image": onboardThree
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    Spacer(),
                    Text(
                      appName,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(36),
                        color: Color(0xFF8f7d5e),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      splashData[index]['text']!,
                      textAlign: TextAlign.center,
                      style: kTextBlackBoldStyle,
                    ),
                    Spacer(flex: 2),
                    Image.asset(
                      splashData[index]["image"]!,
                      height: getProportionateScreenHeight(265),
                      width: getProportionateScreenWidth(235),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                            splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    BlackButton(
                      login,
                      () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xFF8f7d5e) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
