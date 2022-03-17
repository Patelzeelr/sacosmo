import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/param_constant.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../provider/cart_provider.dart';
import '../provider/favourite_provider.dart';
import '../widgets/custom_alignment.dart';
import '../widgets/custom_black_button.dart';
import 'cart_detail_screen.dart';
import 'wishlist_screen.dart';

class DetailScreen extends StatefulWidget {
  final dynamic doc;

  const DetailScreen({
    Key? key,
    this.doc,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ReviewCartProvider reviewCartProvider;
  int count = 1;

  void showMessage(String value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  getData() async {
    reviewCartProvider =
        Provider.of<ReviewCartProvider>(context, listen: false);

    var data = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('cartDetail')
        .get();

    reviewCartProvider.addReviewCartData(
        image: widget.doc[paramImage],
        productName: widget.doc[paramProductName],
        productPrice: widget.doc[paramProductPrice],
        productCount: count);
  }

  addToCart() async {
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
          if (element[paramProductName] == widget.doc[paramProductName]) {
            await FirebaseFirestore.instance
                .collection('user')
                .doc(FirebaseAuth.instance.currentUser?.email)
                .collection('cartDetail')
                .doc(element.id)
                .update({
              'productCount': (element[paramProductCount] + 1),
            });
            return;
          }
        }
        if (querySnapshot.docs.isNotEmpty) {
          reviewCartProvider.addReviewCartData(
              image: widget.doc[paramImage],
              productName: widget.doc[paramProductName],
              productPrice: widget.doc[paramProductPrice],
              productCount: count);
        }
      }
      if (querySnapshot.docs.isEmpty) {
        reviewCartProvider.addReviewCartData(
            image: widget.doc[paramImage],
            productName: widget.doc[paramProductName],
            productPrice: widget.doc[paramProductPrice],
            productCount: count);
      }
    });
  }

  bool wishListBool = false;

  Future getWishtListBool() async {
    final snapshots = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("favourite")
        .doc(widget.doc[paramProductName])
        .get();

    setState(() {
      wishListBool = snapshots.get("favourite");
    });
  }

  @override
  void initState() {
    super.initState();
    getWishtListBool();
  }

  @override
  Widget build(BuildContext context) {
    FavouriteProvider favProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WishListScreen(doc: widget.doc) //ReviewCart()
                      ),
                );
              },
              icon: const Icon(Icons.favorite),
              color: black),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.share), color: black),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.network(widget.doc[paramImage],
                      height: 300.0, width: 300.0)),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 200.0,
                      child: Text(widget.doc[paramProductName],
                          style: kTextBoldBigStyle)),
                  Text('\$${widget.doc[paramProductPrice]}',
                      style: kTextGreyBigBoldStyle),
                ],
              ),
              SizedBox(height: 15.0),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: pink),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(height: 15.0),
              Text('Color', style: kTextBlackBoldStyle),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.doc['colors']['shade1'] == ""
                      ? Text("No Shade Available....",
                          style: kTextBlackBoldStyle)
                      : Row(
                          children: [
                            Image(
                                image: NetworkImage(
                                    widget.doc['colors']['shade1'])),
                            SizedBox(width: 5.0),
                            Image(
                                image: NetworkImage(
                                    widget.doc['colors']['shade2'])),
                            SizedBox(width: 5.0),
                            Image(
                                image: NetworkImage(
                                    widget.doc['colors']['shade3'])),
                          ],
                        ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: grey.withOpacity(0.2), blurRadius: 8.0)
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          wishListBool = !wishListBool;
                        });
                        if (wishListBool == false) {
                          print("hwllo");
                          print(widget.doc.id);
                          FirebaseFirestore.instance
                              .collection("user")
                              .doc(FirebaseAuth.instance.currentUser?.email)
                              .collection("favourite")
                              .doc(widget.doc[paramProductName])
                              .delete()
                              .then((value) => print("hello zeel"));
                        } else {
                          favProvider.addFavouriteData(
                              image: widget.doc[paramImage],
                              productName: widget.doc[paramProductName],
                              productPrice: widget.doc[paramProductPrice]);
                          showMessage("Your item is added to wishlist");
                        }
                      },
                      icon: wishListBool == false
                          ? Icon(Icons.favorite_outline, color: red)
                          : Icon(Icons.favorite, color: red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(widget.doc[paramProductDetail], style: kTextGreyBigStyle),
              CustomAlignmnet(
                Alignment.center,
                BlackButton("Add to cart", () async {
                  addToCart();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartDetail() //ReviewCart()
                        ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
