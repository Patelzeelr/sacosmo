import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  void addReviewCartData({
    required String image,
    required String productName,
    required String productPrice,
  }) async {
    Map<String, dynamic> cartData = {
      "image": image,
      "productName": productName,
      "productPrice": productPrice,
      "isAdd":true,
    };
    FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.email).collection("cartDetail").add(cartData);
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
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }


//// TotalPrice  ///
double total = 0.0;
/*  getTotalPrice([double value = 0.0]){
    total = value;
    for (var element in reviewCartDataList) {
      total += double.parse(element.productPrice);
      print(total);
      notifyListeners();

    }
  }*/

  void updateAmount(dynamic data, [double value = 0.0]) {
    total = value;
    for (int i = 0; i < data.length; i++) {
      total += double.parse(data[i]['productPrice']);
      print(total);
      notifyListeners();
    }
  }

  double get totalCount {
    return total;
  }

}