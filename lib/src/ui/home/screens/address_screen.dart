import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/icons_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../base/constants/param_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../widgets/custom_address_row.dart';

class AddressScreen extends StatefulWidget {
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List _allResults = [];

  getProductDetail() async {
    var data = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('addressList')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    print(_allResults);
    return "complete";
  }

  @override
  void initState() {
    super.initState();
    getProductDetail();
  }

  void showMessage(String value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(iconArrow, color: black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
                itemCount: _allResults.length,
                itemBuilder: (context, i) {
                  final data = _allResults[i];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[paramTitle],style: kTextBoldStyle),
                              SizedBox(height: 10.0),
                              CustomAddressRow(iconAccount, Text(data[paramFirstName] + data[paramLastName],style: kTextGreyBigBoldStyle)),
                              SizedBox(height: 10.0),
                              CustomAddressRow(iconAddress, SizedBox(width:180.0,child: Text(data[paramSociety] + data[paramLandmark] + data[paramArea] + data[paramCity],style: kTextBlackSmallStyle))),
                              SizedBox(
                                height: 20.0,
                                width: 300.0,
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: 1.0,
                                    color: grey,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  CustomAddressRow(iconPhone, SizedBox(width:180.0,child: Text(data[paramMobileNo],style: kTextBlackSmallStyle)),),
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: black,
                                      side: BorderSide(width: 1, color: black),
                                    ),
                                    onPressed: () {
                                      FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.email).collection("addressList").doc(data.id).delete();
                                      showMessage('Your Address is Deleted');
                                    },
                                    child: Text('Delete',style: kTextWhiteSmallStyle),
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: white,
                      boxShadow: [
                        BoxShadow(color: grey.withOpacity(0.2), blurRadius: 8.0),
                      ],
                    ),
                  );
                }),
          ),

    );
  }
}