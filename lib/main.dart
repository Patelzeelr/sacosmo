import 'package:cosmo_beauty/src/ui/auth/screens/forgot_password_number_screen.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/forgot_password_otp_screen.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/login_screen.dart';
import 'package:cosmo_beauty/src/ui/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
 /* SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
