import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  void addReviewCartData({
    required String image,
    required String productName,
    required String productPrice,
    required int productCount,
  }) async {
    Map<String, dynamic> cartData = {
      "image": image,
      "productName": productName,
      "productPrice": productPrice,
      "productCount": productCount,
      "isAdd":true,
    };
    await FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.email).collection("cartDetail").add(cartData);
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.email).collection("cartDetail").get();


    reviewCartValue.docs.forEach((element) {
      print(element.id);
      ReviewCartModel reviewCartModel = ReviewCartModel(
        image: element.get("image"),
        productName: element.get("productName"),
        productPrice: element.get("productPrice"), 
        productCount: element.get("productCount"),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

  void updateReviewCartData({
    required String image,
    required String productName,
    required String productPrice,
    required int productCount,
  }) async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("cartDetail")
        .doc()
        .update(
        {
          "cartName": productName,
          "cartImage": image,
          "cartPrice": productPrice,
          "cartQuantity": productCount,
          "isAdd":true,
        },
    );
  }


//// TotalPrice  ///
double total = 0.0;
  void updateAmount(dynamic data, [double value = 0.0]) {
    total = value;
    for (int i = 0; i < data.length; i++) {
      total += double.parse(data[i]['productPrice']) * data[i]['productCount'];
      print(total);
      notifyListeners();
    }
  }

  double get totalCount {
    return total;
  }


}