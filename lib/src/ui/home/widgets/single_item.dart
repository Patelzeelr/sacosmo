import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../base/constants/color_constant.dart';
import '../provider/cart_provider.dart';

class SingleItem extends StatefulWidget{

  //late String cartId;
  late String image;
  late String productName;
  late String productPrice;
  late Function onDelete;

  SingleItem(this.image,this.productName,this.productPrice,this.onDelete);

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late ReviewCartProvider reviewCartProvider;

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Column(
      children: [
        Expanded(
        child: Container(
        height: 90,
          child: Center(
            child: Image.network(
              widget.image,
            ),
          ),
        ),
        ),
        Expanded(
        child: Container(
        height: 90,
        child: Column(
        children: [
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
        widget.productName,
        style: TextStyle(
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 16),
        ),
        Text(
        "${widget.productPrice}\$",
        style: TextStyle(
        color: black, fontWeight: FontWeight.bold),
        ),
        ],
        ),
      ],

    ),
    ),
    )
    ]
    );
  }
}