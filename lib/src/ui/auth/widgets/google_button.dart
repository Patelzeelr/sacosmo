import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/color_constant.dart';
import '../../home/screens/bottom_screen.dart';
import '../model/firebase_service.dart';

class GoogleButton extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: white,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
            onPressed: () async{
              FirebaseService service = new FirebaseService();
              try {
                await service.signInwithGoogle();
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => BottomScreen()
                ));
              } catch (e) {
                if (e is FirebaseAuthException) {
                  print(e.message!);
                }
              }
            },
            minWidth: MediaQuery.of(context).size.width * 0.4,
            height: 42.0,
            child: Image.asset('assets/images/google.png',height: 26.0,width: 26.0,)
        ),
      ),
    );
  }
}