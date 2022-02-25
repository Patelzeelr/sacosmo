import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/strings_constant.dart';
import 'package:cosmo_beauty/src/ui/auth/screens/register_screen.dart';
import 'package:cosmo_beauty/widgets/custom_black_button.dart';
import 'package:cosmo_beauty/widgets/custom_socialmedia_button.dart';
import 'package:cosmo_beauty/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   return Scaffold(
     appBar: AppBar(
       elevation: 0.0,
       backgroundColor: Colors.white,
       title: Text(
         login,
         style: TextStyle(fontFamily: 'Raleway',color: Colors.black,fontWeight: FontWeight.bold),),
       centerTitle: true,
       leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
     ),
     body: Padding(
       padding: EdgeInsets.all(20.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           CustomTextField(email, (value){}),
           SizedBox(height: 20.0),
           _sufixTextField(),
           SizedBox(height: 20.0),
           BlackButton(
               login, () {
             Navigator.pushReplacement(context, MaterialPageRoute(
                 builder: (context) => RegisterScreen()
             ));
           }),
           SizedBox(height: 20.0),
           Text(socialMediaLabel),
           SizedBox(height: 30.0),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SocialMediaButton(fbColor,Icons.facebook,white,(){}),
               SizedBox(width: 20.0),
               _googleButton(context)
               //SocialMediaButton(white,Icons.g_mobiledata,Colors.orange,(){}),
             ],
           )
         ],
       ),
     )
   );
  }

  Widget _sufixTextField() => TextFormField(
    keyboardType: TextInputType.text,
    cursorColor: grey,
    decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: darkGrey)
        ),
        focusColor: Colors.red,
        labelText: password,
        labelStyle: TextStyle(
            color: grey
        ),
      suffix: Text('Forgot?',style: TextStyle(color: grey),),
    ),
    onChanged: (value) {

    },
    style: const TextStyle(color: black,fontWeight: FontWeight.bold),
  );

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