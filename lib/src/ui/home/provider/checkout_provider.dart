import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/address_model.dart';
import '../model/cart_model.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;

  TextEditingController title = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController scoiety = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController aera = TextEditingController();
  TextEditingController pincode = TextEditingController();

  void validator(context, myType) async {
    if (title.text.isEmpty) {
      print("firstname is empty");
    }else if (firstName.text.isEmpty) {
      print("firstname is empty");
    } else if (lastName.text.isEmpty) {
      print("lastname is empty");
    } else if (mobileNo.text.isEmpty) {
      print("mobileNo is empty");
    } else if (alternateMobileNo.text.isEmpty) {
      print("alternateMobileNo is empty");
    } else if (scoiety.text.isEmpty) {
      print("scoiety is empty");
    } else if (street.text.isEmpty) {
      print("street is empty");
    } else if (landmark.text.isEmpty) {
      print("landmark is empty");
    } else if (city.text.isEmpty) {
      print("city is empty");
    } else if (aera.text.isEmpty) {
      print("aera is empty");
    } else if (pincode.text.isEmpty) {
      print("pincode is empty");
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('addressList')
          .add({
        "title": title.text,
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "scoiety": scoiety.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "aera": aera.text,
        "pincode": pincode.text,
        "addressType": myType.toString(),
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        print("Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;

    QuerySnapshot addressValue = await FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.email).collection("addressList").get();


    addressValue.docs.forEach((element) {
      print(element.id);
      deliveryAddressModel = DeliveryAddressModel(
        element.get("title"),
        element.get("firstname"),
        element.get("lastname"),
        element.get("addressType"),
        element.get("aera"),
        element.get("alternateMobileNo"),
        element.get("city"),
        element.get("landmark"),
        element.get("mobileNo"),
        element.get("pincode"),
        element.get("scoiety"),
        element.get("street"),
      );
      newList.add(deliveryAddressModel);
    });
    deliveryAdressList = newList;
    notifyListeners();
  }
}
