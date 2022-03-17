import 'dart:async';
import 'package:cosmo_beauty/src/ui/welcome/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/image_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../../home/screens/bottom_screen.dart';

class SplashScreen extends StatefulWidget{

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      final _currentUser = FirebaseAuth.instance.currentUser;

      if (_currentUser?.email != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => BottomScreen() //ReviewCart()
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => WelcomeScreen() //ReviewCart()
        ));
      }
    });
  }

  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: splashScreenColor,
            width: size.width * 100,
            height: size.height * 100,
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: const Image(image: AssetImage(appLogo)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left:90.0,top: 550.0),
            child: const SizedBox(
                width: 250.0,
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Raleway',
                    color: splashScreenTextColor
                  ),
                  child: Text(appName),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}