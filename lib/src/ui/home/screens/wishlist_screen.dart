import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../base/constants/strings_constant.dart';
import 'cart_detail_screen.dart';

class WishListScreen extends StatefulWidget{

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final Stream<QuerySnapshot> favItems = FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.email).collection('favourite').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        title: Text('Wish List',style: kTextBoldStyle),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => CartDetail()//ReviewCart()
            ));
          }, icon: Icon(Icons.shopping_bag_outlined),color: black,)
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
              stream: favItems,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.requireData.size,
                  itemBuilder: (context, i) {
                    final data = snapshot.requireData.docs[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Image(image: NetworkImage(data['image']),height: MediaQuery.of(context).size.height * 0.2,width: MediaQuery.of(context).size.width * 0.25,),
                          SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 160,child: Text(data['productName'],style: kTextBlackBoldStyle)),
                              SizedBox(height: 2.0),
                              Text(data['productPrice'],style: kTextBlackBoldStyle),
                              SizedBox(height: 10.0),
                              OutlinedButton(onPressed: (){
                                Map<String, dynamic> cartData = {
                                  "image": data['image'],
                                  "productName": data['productName'],
                                  "productPrice": data['productPrice'],
                                  "isAdd":true,
                                };
                                FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.email).collection("cartDetail").add(cartData);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => CartDetail()//ReviewCart()
                                ));
                              }, child: Text('Move To Bag',style: TextStyle(color: black))),
                            ],
                          ),
                          IconButton(onPressed: (){
                            FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.email).collection("favourite").doc(data.id).delete();
                          }, icon: Icon(Icons.close)),
                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) => Divider(height: 0.0,thickness: 0.0,color: Color(0xFFede3da)),
                );
              },
            ),
        ),
    );
  }
}