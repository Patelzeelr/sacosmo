import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cosmo_beauty/src/ui/home/screens/bottom_screen.dart';
import 'package:cosmo_beauty/src/ui/welcome/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      final _currentUser = FirebaseAuth.instance.currentUser;

      if (_currentUser?.email != null) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => BottomScreen() //ReviewCart()
        ));
      } else {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => WelcomeScreen() //ReviewCart()
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width * 100,
            height: size.height * 100,
            // color: Colors.orange,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/spbg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left:90.0,top: 550.0),
            child: SizedBox(
                width: 250.0,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Raleway',
                    color: Color(0xFF8f7d5e)
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('SA COSMO BEAUTY'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}