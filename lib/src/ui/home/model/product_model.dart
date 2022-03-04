import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productBrand;
  String productName;
  String productImage;
  String productPrice;

  ProductModel(this.productBrand,this.productImage, this.productName, this.productPrice);

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) :
        productBrand = snapshot['productBrand'],
        productName = snapshot['productName'],
        productImage = snapshot['image'],
        productPrice = snapshot['productPrice'];
}