import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FavouriteProvider with ChangeNotifier {
  addFavouriteData({
    required String productName,
    required String productPrice,
    required String image,
  }) {
    Map<String, dynamic> favouriteData = {
      //"cartId": cartId,
      "image": image,
      "productName": productName,
      "productPrice": productPrice,
      "favourite":true,
    };
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("favourite").add(favouriteData);
  }
}