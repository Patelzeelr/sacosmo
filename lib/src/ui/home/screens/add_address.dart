import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/param_constant.dart';
import 'package:cosmo_beauty/src/base/methods/validation_method.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';


class AddAddress extends StatefulWidget{

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final mobileNo = TextEditingController();
  final alternateMobileNo = TextEditingController();
  final society = TextEditingController();
  final street = TextEditingController();
  final landmark = TextEditingController();
  final city = TextEditingController();
  final area = TextEditingController();
  final pincode = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        title: const Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: MaterialButton(
          onPressed: () {
          if (_formKey.currentState!.validate()) {
            FirebaseFirestore.instance
                .collection("user")
                .doc(FirebaseAuth.instance.currentUser?.email)
                .collection('addressList')
                .add({
              paramTitle: title.text,
              paramFirstName: firstName.text,
              paramLastName: lastName.text,
              paramMobileNo: mobileNo.text,
              paramAlternateMobileNo: alternateMobileNo.text,
              paramSociety: society.text,
              paramStreet: street.text,
              paramLandmark: landmark.text,
              paramCity: city.text,
              paramArea: area.text,
              paramPincode: pincode.text,
            }).then((value) async {
              Navigator.of(context).pop();
            });
          }
          },
          child: const Text(
              addAddress,
              style: kTextWhiteStyle
          ),
          color: black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                  textTitle,
                  title,
                  (value){
                    value = title.text;
                  },
                      (value) {
                    if (value!.isEmpty) {
                      return (emptyTitle);
                    }
                  },
                false
              ),
              CustomTextField(
                  textFirstName,
                  firstName,
                      (value){
                    value = firstName.text;
                  },
                      (value) {
                    if (value!.isEmpty) {
                      return (emptyFirstName);
                    }
                  },
                false
              ),
              CustomTextField(
                  textLastName,
                  lastName,
                      (value){
                    value = lastName.text;
                  },
                      (value) {
                    if (value!.isEmpty) {
                      return (emptyLastName);
                    }
                  },
                false
              ),
              CustomTextField(
                  textMobileNo,
                  mobileNo,
                      (value){
                    value = mobileNo.text;
                  },
                   validateMobile,
                false
              ),
              CustomTextField(
                  textAlternateMobileNo,
                  alternateMobileNo,
                      (value){
                    value = alternateMobileNo.text;
                  },
                   validateMobile,
                false
              ),
              CustomTextField(
                  textScoiety,
                  society,
                      (value){
                    value = society.text;
                  },
                      (value) {
                    if (value!.isEmpty) {
                      return (emptyAddress);
                    }
                  },
                false
              ),
              CustomTextField(
                  textStreet,
                  street,
                      (value){
                    value = street.text;
                  },
                      (value) {
                    if (value!.isEmpty) {
                      return (emptyAddress);
                    }
                  },
                false
              ),
              CustomTextField(
                  textLandmark,
                  landmark,
                      (value){
                    value = landmark.text;
                  },
                      (value) {
                    if (value!.isEmpty) {
                      return (emptyAddress);
                    }
                  },
                false
              ),
              CustomTextField(
                  textCity,
                  city,
                      (value){
                    value = city.text;
                  },
                      (value) {
                    if (value!.isEmpty) {
                      return (emptyAddress);
                    }
                  },
                false
              ),
              CustomTextField(
                  textAera,
                  area,
                      (value){
                    value = area.text;
                  },
                      (value) {
                    if (value!.isEmpty) {
                      return (emptyAddress);
                    }
                  },
                false
              ),
              CustomTextField(
                  textPincode,
                  pincode,
                      (value){
                    value = pincode.text;
                  },
                      (value) {
                    if (value!.isEmpty) {
                      return (emptyAddress);
                    }
                  },
                false
              ),
            ],
          ),
        ),
      ),
    );
  }
}