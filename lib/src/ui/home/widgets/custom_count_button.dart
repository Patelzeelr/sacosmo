import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CountButton extends StatefulWidget {
  final String productId;
  final String image;
  final String productName;
  final String productPrice;
  final int productCount;

  const CountButton(this.productId, this.image, this.productName, this.productPrice, this.productCount);

  @override
  State<CountButton> createState() => _CountButtonState();
}

class _CountButtonState extends State<CountButton> {
  @override
  Widget build(BuildContext context) {
    int count = 1;
    bool isTrue = false;

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: black,
        elevation: 10.0,
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
        ),
    );
  }
}