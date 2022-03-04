import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/ui/home/screens/success_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_black_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/strings_constant.dart';
import '../provider/cart_provider.dart';


class PaymentScreen extends StatefulWidget{
  final dynamic doc;

  const PaymentScreen({Key? key, this.doc}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        title: Text('Payment',style: kTextBlackBoldStyle),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: black),onPressed: (){
          Navigator.pop(context);
        },)
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image(image: AssetImage('assets/images/payment.png')),
            BlackButton('Pay  \$${Provider.of<ReviewCartProvider>(context).totalCount}',
                    (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SuccessScreen()
                      ));
                    })
          ],
        ),
      ),
    );
  }
}