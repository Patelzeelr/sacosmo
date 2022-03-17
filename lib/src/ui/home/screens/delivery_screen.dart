import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/color_constant.dart';
import '../../../base/constants/icons_constant.dart';
import '../../../base/constants/param_constant.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../provider/checkout_provider.dart';
import '../widgets/custom_address_row.dart';
import 'add_address.dart';
import 'payment_screen.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  List _allResults = [];

  getAddressDetail() async{
    var data = await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.email).collection('addressList').get();
    setState(() {
      _allResults =  data.docs;
    });
    print(_allResults);
    return "complete";

  }


  @override
  void initState() {
    super.initState();
    getAddressDetail();
  }


  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: IconButton(icon: Icon(iconArrow,color: black), onPressed: (){
          Navigator.pop(context);
        },),
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: _allResults.isEmpty
              ? Text("Add Address", style: kTextWhiteStyle)
              : Text("Payment Summary", style: kTextWhiteStyle),
          onPressed: (){
            _allResults.isEmpty
                ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddAddress()))
                : Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen()));
          },
            color: black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
        )
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _allResults.isEmpty ? Text("") : Text("Deliver To"),
            SizedBox(height: 10.0),
            Divider(
              height: 1,
            ),
            Flexible(
                child:  RefreshIndicator(
                  onRefresh: ()async{
                    getAddressDetail();
                  },
                  child:ListView.builder(
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
                                  CustomAddressRow(Icons.account_circle, Text(data[paramFirstName] + data[paramLastName],style: kTextGreyBigBoldStyle)),
                                  SizedBox(height: 10.0),
                                  CustomAddressRow(Icons.home_work_outlined, SizedBox(width:180.0,child: Text(data[paramSociety] + data[paramLandmark] + data[paramArea] + data[paramCity],style: kTextBlackSmallStyle))),
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
                                  CustomAddressRow(Icons.phone_android, SizedBox(width:180.0,child: Text(data[paramMobileNo],style: kTextBlackSmallStyle)),)
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
                    }
                ),
    ),
            ),
    ]
    ),
    ),
    );
                }
}