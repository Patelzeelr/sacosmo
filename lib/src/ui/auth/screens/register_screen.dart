import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/ui/auth/widgets/socialMedia_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../../../base/methods/validation_method.dart';
import '../../home/screens/bottom_screen.dart';
import '../../home/widgets/custom_black_button.dart';
import '../../home/widgets/custom_textfield.dart';
import '../widgets/circular_indicator.dart';

class RegisterScreen extends StatefulWidget{

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool isIndicate = false;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _addUser() {
    Map<String, dynamic> userData = {
      'name': userNameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };
    _firestore.collection('user').doc(
        emailController.text).set(userData);
  }

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
        body: isIndicate ? CircularIndicator() : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    fullName,
                    userNameController,
                        (value){ value = userNameController.text.trim();},
                        validateUserName,
                    false,
                  ),
                  SizedBox(height: 20.0),
                  CustomTextField(
                    email,
                    emailController,
                        (value){ value = emailController.text.trim();},
                       validateEmail,
                    false,
                  ),
                  SizedBox(height: 20.0),
                  CustomTextField(
                    password,
                    passwordController,
                        (value){ value = passwordController.text.trim();},
                    validatePassword,
                    true,
                  ),
                  const SizedBox(height: 20.0),
                  _richText(),
                  BlackButton(
                      signup, () async{
                      setState(() {
                        isIndicate = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          final newUser = await _auth
                              .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                          _addUser();
                          if (newUser != null) {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(
                                builder: (context) => BottomScreen()
                            ));
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                  }),
                  SizedBox(height: 20.0),
                  Text(socialMediaLabel),
                  SizedBox(height: 20.0),
                  SocialMediaRow()
                ],
              ),
            ),
          ),
        )
    );
  }
  _richText() => RichText(
    text: const TextSpan(
        text: registerTextTerm,
        style: TextStyle(fontWeight: FontWeight.bold,color: black),
        children: [
          TextSpan(text: registerTextMid,style: TextStyle(color: grey)),
          TextSpan(text: registerTextPolicy,style: TextStyle(fontWeight: FontWeight.bold,color: black)),
        ]
    ),
  );
}