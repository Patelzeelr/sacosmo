import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/strings_constant.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/forgot_password_number_screen.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/forgot_password_otp_screen.dart';
import 'package:cosmo_beauty/widgets/custom_black_button.dart';
import 'package:cosmo_beauty/widgets/custom_socialmedia_button.dart';
import 'package:cosmo_beauty/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget{

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
          leading: const Icon(Icons.arrow_back_ios,color: Colors.black,),

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(fullName, (value){}),
                SizedBox(height: 20.0),
                CustomTextField(email, (value){}),
                SizedBox(height: 20.0),
                CustomTextField(password, (value){}),
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
                BlackButton(signup, () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => ForgotPasswordNumberScreen()
                  ));
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
                    _googleButton(context),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
  Widget _googleButton(context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: Material(
      color: white,
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
          onPressed: (){},
          minWidth: MediaQuery.of(context).size.width * 0.4,
          height: 42.0,
          child: Image.asset('assets/images/google.png',height: 26.0,width: 26.0,)
      ),
    ),
  );
}