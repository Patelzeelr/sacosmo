import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String productName;
  String productImage;
  String productPrice;

  CategoryModel(this.productImage, this.productName, this.productPrice);

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot) :
        productName = snapshot['productName'],
        productImage = snapshot['image'],
        productPrice = snapshot['productPrice'];
}