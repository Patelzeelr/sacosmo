import 'package:cosmo_beauty/src/ui/auth/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../../../base/methods/validation_method.dart';
import '../../home/screens/bottom_screen.dart';
import '../../home/widgets/custom_alignment.dart';
import '../../home/widgets/custom_black_button.dart';
import '../../home/widgets/custom_textfield.dart';
import '../widgets/circular_indicator.dart';
import '../widgets/socialMedia_row.dart';


class LoginScreen extends StatefulWidget{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool isIndicate = false;

  final _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       elevation: 0.0,
       backgroundColor: white,
       title: const Text(
         login,
         style: TextStyle(fontFamily: 'Raleway',color: Colors.black,fontWeight: FontWeight.bold),),
       centerTitle: true,
     ),
     body: isIndicate ? CircularIndicator() : SingleChildScrollView(
       child: Padding(
         padding: EdgeInsets.all(20.0),
         child: Form(
           key: _formKey,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
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
               SizedBox(height: 20.0),
               GestureDetector(
                 onTap: (){
                   FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
                 },
                 child: CustomAlignmnet(Alignment.topRight,Text(forgot, style: kTextGreyBoldStyle)),
               ),
               BlackButton(
                   login, () async{
                    setState(() {
                      isIndicate = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        if (user != null) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
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
               SizedBox(height: 30.0),
               SocialMediaRow(),
               SizedBox(height: 20.0),
               BlackButton(
                   register , () {
                 Navigator.pushReplacement(context, MaterialPageRoute(
                     builder: (context) => RegisterScreen()
                 ));
               }),
             ],
           ),
         ),
       ),
     )
   );
  }
}