import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/strings_constant.dart';
import 'package:cosmo_beauty/widgets/custom_black_button.dart';
import 'package:cosmo_beauty/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordNumberScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: offWhite,
        title: Text(
          forgot,
          style: TextStyle(fontFamily: 'Raleway',color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(forgotText,style: TextStyle(color: grey),),
            SizedBox(height: 20.0),
            _phoneField(),
            SizedBox(height: 20.0),
            BlackButton("Send", (){}),
          ],
        ),
      ),
    );
  }

  Widget _phoneField() => TextFormField(
    keyboardType: TextInputType.emailAddress,
    cursorColor: grey,
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkGrey)
      ),
      focusColor: Colors.red,
      hintText: email,
      prefixIcon: Icon(Icons.email_outlined,color: black,)
    ),
    onChanged: (value) {

    },
    style: const TextStyle(color: black,fontWeight: FontWeight.bold),
  );
}

