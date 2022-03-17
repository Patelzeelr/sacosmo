import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/icons_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/param_constant.dart';
import '../../home/screens/bottom_screen.dart';
import '../../home/widgets/custom_socialmedia_button.dart';
import 'google_button.dart';

class SocialMediaRow extends StatefulWidget{

  @override
  State<SocialMediaRow> createState() => _SocialMediaRowState();
}

class _SocialMediaRowState extends State<SocialMediaRow> {
  void _loginWithFacebook() async{
    try{
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      Map<String, dynamic> data = {
        'name': userData[paramName],
        'email': userData[paramEmail],
      };

      await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.email).collection('facebookUser').add(data);

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => BottomScreen()
      ));
    } catch(e) { print(e); }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaButton(fbColor,facebook,white,(){
          _loginWithFacebook();
        }),
        const SizedBox(width: 20.0),
        GoogleButton(),
      ],
    );
  }
}