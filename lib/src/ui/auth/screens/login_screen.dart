import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/strings_constant.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/register_screen.dart';
import 'package:cosmo_beauty/src/ui/auth/widgets/google_button.dart';
import 'package:cosmo_beauty/src/ui/home/screens/bottom_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_alignment.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_black_button.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_socialmedia_button.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class LoginScreen extends StatefulWidget{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _loginWithFacebook() async{
    try{
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      Map<String, dynamic> data = {
        'name': userData['name'],
        'email': userData['email'],
      };

      await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.email).collection('facebookUser').add(data);

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => BottomScreen()
      ));
    } catch(e) { print(e); }
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       elevation: 0.0,
       backgroundColor: Colors.white,
       title: const Text(
         login,
         style: TextStyle(fontFamily: 'Raleway',color: Colors.black,fontWeight: FontWeight.bold),),
       centerTitle: true,
     ),
     body: SingleChildScrollView(
       child: Padding(
         padding: EdgeInsets.all(20.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             CustomTextField(email, emailController,(value){
               value = emailController.text.trim();
             },false),
             SizedBox(height: 20.0),
             _sufixTextField(),
             SizedBox(height: 20.0),
             GestureDetector(
               onTap: (){
                 FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
               },
               child: CustomAlignmnet(Alignment.topRight,Text('Forgot Password?', style: kTextGreyBoldStyle)),
             ),
             BlackButton(
                 login, () async{
               try{
                 final user = await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                 if(user != null) {
                   Navigator.pushReplacement(context, MaterialPageRoute(
                       builder: (context) => BottomScreen()
                   ));
                 }
                 } catch(e) { print(e); }

             }),
             SizedBox(height: 20.0),
             BlackButton(
                 'Register', () {
                   Navigator.pushReplacement(context, MaterialPageRoute(
                       builder: (context) => RegisterScreen()
                   ));
             }),
             Text(socialMediaLabel),
             SizedBox(height: 30.0),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 SocialMediaButton(fbColor,Icons.facebook,white,(){
                   _loginWithFacebook();
                 }),
                 SizedBox(width: 20.0),
                 GoogleButton()
               ],
             )
           ],
         ),
       ),
     )
   );
  }
  Widget _sufixTextField() => TextFormField(
    keyboardType: TextInputType.text,
    cursorColor: grey,
    obscureText: true,
    decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: darkGrey)
        ),
        focusColor: Colors.red,
        labelText: 'password',
        labelStyle: TextStyle(
            color: grey
        ),
    ),
    controller: passwordController,
    onChanged: (value) {
      value = passwordController.text.trim();
    },
    style: const TextStyle(color: black,fontWeight: FontWeight.bold),
  );
}