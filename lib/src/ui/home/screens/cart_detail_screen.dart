import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../model/cart_model.dart';
import '../provider/cart_provider.dart';
import '../widgets/custom_alignment.dart';
import 'delivery_screen.dart';

class CartDetail extends StatefulWidget{

  @override
  State<CartDetail> createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {

  @override
  void initState() {
    super.initState();
    getCurrentData(context);
  }


  Future getCurrentData(context) async {
    final Stream<QuerySnapshot> snapshot = FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.email).collection('cartDetail').snapshots();

    snapshot.forEach((element) {
      Provider.of<ReviewCartProvider>(context, listen: false)
          .updateAmount(element.docs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back_ios),color: black),
        title: Text('Cart',style: kTextBoldBigStyle),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.email).collection('cartDetail').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: ScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              final data = snapshot.data?.docs[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Image(image: NetworkImage(data!['image']),height: MediaQuery.of(context).size.height * 0.2,width: MediaQuery.of(context).size.width * 0.25,),
                    SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 160.0,child: Text(data['productName'],style: kTextBlackBoldStyle)),
                        SizedBox(height: 2.0),
                        Text('\$ ${data['productPrice']}',style: kTextBlackBoldStyle),
                      ],
                    ),
                    IconButton(onPressed: (){
                      FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.email).collection("cartDetail").doc(data.id).delete();
                    }, icon: Icon(Icons.close)),
                  ],
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) => Divider(height: 0.0,thickness: 0.0,color: Color(0xFFede3da)),
          );
        }
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //\$ ${reviewCartProvider.getTotalPrice()}
            Text('Grand Total: ${Provider.of<ReviewCartProvider>(context).totalCount}',style: kTextBoldStyle),
            GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DeliveryDetails(),
                    ),
                  );
                },
                child: Container(
                    height: 55.0,
                    width: 150.0,
                    color: black,
                    child: CustomAlignmnet(Alignment.center,Text('Check Out',style: kTextWhiteStyle))
                )
            ),
          ],
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        // reviewCartProvider.reviewCartDataDelete();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}