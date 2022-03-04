import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/ui/home/screens/payment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../model/address_model.dart';
import '../provider/checkout_provider.dart';
import 'add_deliver_address.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  List _allResults = [];

  getProductDetail() async{
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
    getProductDetail();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: black), onPressed: (){
          Navigator.pop(context);
        },),
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          //deliveryAddressProvider.getDeliveryAddressList.isEmpty
            child: Text("Add new Address",style: TextStyle(color: white)),
          onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDeliverAddress(),
              ),
            );
          },
          color: black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deliver To"),
            SizedBox(height: 10.0),
            Divider(
              height: 1,
            ),
            Flexible(
                child:  RefreshIndicator(
                  onRefresh: ()async{
                    getProductDetail();
                  },
                  child:ListView.builder(
                    itemCount: _allResults.length,
                    itemBuilder: (context, i) {
                      final data = _allResults[i];
                      return GestureDetector(
                        onTap: () {
                          if(data != null){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PaymentScreen(doc: data)
                            ));
                          } else{
                            print(data['pincode']);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_rounded),
                                        SizedBox(height: 10.0),
                                        Text(data['title'],style: kTextBoldStyle)
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(data['firstname'] + data['lastname'],style: kTextGreyBigBoldStyle),
                                    SizedBox(height: 10.0),
                                    SizedBox(width:180.0,child: Text(data['scoiety'] + data['landmark'] + data['aera'],style: kTextBlackSmallStyle)),
                                    SizedBox(height: 10.0),
                                    Text(data['city'],style: kTextBlackSmallStyle),
                                    SizedBox(height: 10.0),
                                    SizedBox(width:180.0,child: Text(data['pincode'],style: kTextBlackSmallStyle)),

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

