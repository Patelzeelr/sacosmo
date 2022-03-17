import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../base/constants/color_constant.dart';

class Count extends StatefulWidget{
  final String productId;
  final String image;
  final String productName;
  final String productPrice;
  final int productCount;

  const Count(this.productId, this.image, this.productName, this.productPrice, this.productCount);

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.productCount);
  }

  @override
  Widget build(BuildContext context) {
    // ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
      height: 25,
      width: 50,
      decoration: BoxDecoration(
          border: Border.all(color: black),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if (count == 1) {
                setState(() {
                  isTrue = false;
                });
              } else if (count > 1) {
                setState(() {
                  count--;
                });
                FirebaseFirestore.instance
                    .collection("user")
                    .doc(FirebaseAuth.instance.currentUser?.email)
                    .collection("cartDetail")
                    .doc(widget.productId)
                    .update(
                  {
                    "image": widget.image,
                    "productName": widget.productName,
                    "productPrice": widget.productPrice,
                    "productCount": count,
                    "isAdd":true,
                  },
                );
              }
            },
            child: Icon(
              Icons.remove,
              size: 15,
              color: black,
            ),
          ),
          Text(
            "${widget.productCount}",
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                count++;
              });
              FirebaseFirestore.instance
                  .collection("user")
                  .doc(FirebaseAuth.instance.currentUser?.email)
                  .collection("cartDetail")
                  .doc(widget.productId)
                  .update(
                {
                  "image": widget.image,
                  "productName": widget.productName,
                  "productPrice": widget.productPrice,
                  "productCount": count,
                  "isAdd":true,
                },
              );
            },
            child: Icon(
              Icons.add,
              size: 15,
              color: black,
            ),
          ),
        ],
      )
    );
  }
}