import 'package:cosmo_beauty/src/base/constants/image_constant.dart';
import 'package:cosmo_beauty/src/ui/home/screens/cart_detail_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_alignment.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_black_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../provider/cart_provider.dart';
import '../provider/favourite_provider.dart';

class DetailScreen extends StatefulWidget {
  final dynamic doc;

  const DetailScreen({Key? key, this.doc,})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ReviewCartProvider reviewCartProvider;


  void showMessage(String value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    FavouriteProvider favProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios), color: black),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite), color: black),
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
              Center(child: Image.network(widget.doc['image'], height: 300.0, width: 300.0)),
              SizedBox(height: 15.0),
              Row(
                children: [
                  SizedBox(width: 200.0, child: Text(widget.doc['productName'], style: kTextBoldBigStyle)),
                  Text(widget.doc['productPrice'], style: kTextGreyBigBoldStyle),],
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
                const Icon(
                    Icons.star,
                    color: pink
                ),
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
                  Row(
                    children: const [
                      Image(image: AssetImage(shade1)),
                      SizedBox(width: 5.0),
                      Image(image: AssetImage(shade2)),
                      SizedBox(width: 5.0),
                      Image(image: AssetImage(shade3)),
                    ],
                  ),
                  CircleAvatar(
                      backgroundColor: grey.withOpacity(0.2),
                      child: IconButton(
                          onPressed: () {
                            favProvider.addFavouriteData(image: widget
                                  .doc['image'], productName: widget
                                  .doc['productName'], productPrice: widget
                                  .doc['productPrice']);
                            showMessage("Your item is added to wishlist");
                          }, icon: Icon(Icons.favorite_border)

                      )
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(demoText, style: kTextGreyBoldStyle),
              CustomAlignmnet(
                  Alignment.center, BlackButton("Add to cart", () async {
                reviewCartProvider.addReviewCartData(image: widget.doc['image'],
                    productName: widget.doc['productName'],
                    productPrice: widget.doc['productPrice']);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CartDetail() //ReviewCart()
                ));
              }))
            ],
          ),
        ),
      ),
    );
  }
}