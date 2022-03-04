import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/strings_constant.dart';
import 'package:cosmo_beauty/src/ui/home/screens/bottom_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_black_button.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_socialmedia_button.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/google_button.dart';

class RegisterScreen extends StatefulWidget{

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
            signup,
            style: TextStyle(fontFamily: 'Raleway',color: Colors.black,fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(fullName,userNameController, (value){
                  value = userNameController.text;
                },false),
                SizedBox(height: 20.0),
                CustomTextField(email, emailController, (value){
                  value = emailController.text;
                },false),
                SizedBox(height: 20.0),
                CustomTextField(password, passwordController, (value){
                  value = passwordController.text;
                },true),
                const SizedBox(height: 20.0),
                RichText(
                    text: const TextSpan(
                      text: 'Terms Of Use ',
                        style: TextStyle(fontWeight: FontWeight.bold,color: black),
                      children: [
                        TextSpan(text: 'and',style: TextStyle(color: grey)),
                        TextSpan(text: ' Privacy Policy',style: TextStyle(fontWeight: FontWeight.bold,color: black)),
                      ]
                    ),
                ),
                BlackButton(signup, () async{
                  try{
                    final newUser = await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                    Map<String, dynamic> userData = {
                      'name': userNameController.text.trim(),
                      'email': emailController.text.trim(),
                      'password': passwordController.text.trim(),
                    };
                    _firestore.collection('user').add(userData);
                    if(newUser != null) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => BottomScreen()
                      ));
                    }
                  } catch (e) { print(e); }
                }),
                SizedBox(height: 20.0),
                const Text(socialMediaLabel),
                SizedBox(height: 20.0),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialMediaButton(fbColor,Icons.facebook,white,(){}),
                    const SizedBox(width: 20.0),
                    GoogleButton(),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}