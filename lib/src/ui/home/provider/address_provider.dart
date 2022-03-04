import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/ui/home/model/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AddressProvider with ChangeNotifier{
  List<DeliveryAddressModel> addressList = [];
  getAddressData() async{
    List<DeliveryAddressModel> newList = [];
    DeliveryAddressModel addressModel;
    DocumentSnapshot _db = (await FirebaseFirestore.instance..collection('user').doc(FirebaseAuth.instance.currentUser?.email).collection('address')) as DocumentSnapshot<Object?>;
    /*if(_db.exists){
      addressModel = DeliveryAddressModel(
          _db.get('title'),
          _db.get('address'),
          _db.get('city'),
          _db.get('pin')
      );
      newList.add(addressModel);
      notifyListeners();
    }*/
    addressList = newList;
    notifyListeners();
  }
  List<DeliveryAddressModel> get getAddressList {
    return addressList;
  }
}
