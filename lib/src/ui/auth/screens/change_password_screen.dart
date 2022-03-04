import 'package:cosmo_beauty/src/ui/auth/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home/widgets/custom_black_button.dart';
import '../../../base/constants/color_constant.dart';
import '../model/firebase_service.dart';

class ChangePassword extends StatelessWidget{

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: offWhite,
        title: Text(
          'New Password',
          style: TextStyle(fontFamily: 'Raleway',color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black), onPressed: (){
          Navigator.pop(context);
        },),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Change Password',style: TextStyle(color: grey),),
            SizedBox(height: 20.0),
            _phoneField(),
            SizedBox(height: 20.0),
            BlackButton("Change Password", () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.updatePassword(passwordController.text.toString());
              FirebaseService service = new FirebaseService();
              try {
                await service.signOutFromGoogle();
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LoginScreen()
                ));
              } catch (e) {
                if (e is FirebaseAuthException) {
                  print(e.message!);
                }
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _phoneField() => TextFormField(
    keyboardType: TextInputType.text,
    cursorColor: grey,
    decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: darkGrey)
        ),
        focusColor: Colors.red,
        hintText: 'Change Password',
        prefixIcon: Icon(Icons.key,color: black,)
    ),
    controller: passwordController,
    onChanged: (value) {
      value = passwordController.text.trim();
    },
    style: const TextStyle(color: black,fontWeight: FontWeight.bold),
  );
}