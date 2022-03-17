import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/color_constant.dart';
import '../../../base/constants/param_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../provider/cart_provider.dart';
import 'cart_detail_screen.dart';
class WishListScreen extends StatefulWidget{

  final dynamic doc;

  const WishListScreen({
    Key? key,
    this.doc,
  }) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final Stream<QuerySnapshot> favItems = FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.email).collection('favourite').snapshots();

  late ReviewCartProvider reviewCartProvider;
  int count = 1;

  addToCart(data) async {
    reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);

    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('cartDetail')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs) {
          if (element[paramProductName] == data[paramProductName]) {
            await FirebaseFirestore.instance
                .collection('user')
                .doc(FirebaseAuth.instance.currentUser?.email)
                .collection('cartDetail')
                .doc(element.id)
                .update({
              paramProductCount: (element[paramProductCount] + 1),
            });
            return;
          }
        }
        if (querySnapshot.docs.isNotEmpty) {
          reviewCartProvider.addReviewCartData(
              image: data[paramImage],
              productName: data[paramProductName],
              productPrice: data[paramProductPrice],
              productCount: count);
        }
      }
      if (querySnapshot.docs.isEmpty) {
        reviewCartProvider.addReviewCartData(
            image: data[paramImage],
            productName: data[paramProductName],
            productPrice: data[paramProductPrice],
            productCount: count);
      }
    });
  }

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
                          Image(image: NetworkImage(data[paramImage]),height: MediaQuery.of(context).size.height * 0.2,width: MediaQuery.of(context).size.width * 0.25,),
                          SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 160,child: Text(data[paramProductName],style: kTextBlackBoldStyle)),
                              SizedBox(height: 2.0),
                              Text(data[paramProductPrice],style: kTextBlackBoldStyle),
                              SizedBox(height: 10.0),
                              OutlinedButton(onPressed: (){
                                addToCart(data);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => CartDetail()//ReviewCart()
                                ));
                                FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(FirebaseAuth.instance.currentUser?.email)
                                    .collection('favourite').doc(data.id).delete();
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