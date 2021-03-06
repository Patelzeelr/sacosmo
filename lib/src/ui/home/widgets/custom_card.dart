import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/param_constant.dart';
import 'package:cosmo_beauty/src/base/constants/strings_constant.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_alignment.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/favourite_icon_button.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/showMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/textstyle_constant.dart';
import '../provider/favourite_provider.dart';

class CustomCard extends StatefulWidget {
  final dynamic doc;

  const CustomCard({Key? key, this.doc}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  List _allResults = [];
  getProductDetail() async {
    var data = await FirebaseFirestore.instance.collection('arrivalItem').get();
    setState(() {
      _allResults = data.docs;
    });
    print(_allResults);
    return "complete";
  }

  @override
  void initState() {
    super.initState();
    getProductDetail();
  }

  @override
  Widget build(BuildContext context) {
    FavouriteProvider favProvider = Provider.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        getProductDetail();
      },
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _allResults.length,
          itemBuilder: (context, i) {
            final data = _allResults[i];
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: white,
                          boxShadow: const [
                            BoxShadow(
                                color: pink, spreadRadius: 0, blurRadius: 3),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CustomAlignmnet(
                                Alignment.topRight,
                                FavouriteIconButton(
                                    () {
                                      favProvider.addFavouriteData(
                                      image: data[paramImage],
                                      productName: data[paramProductName],
                                      productPrice: data[paramProductPrice]);
                                      showMessage(wishlistMessage);
                                    },
                                )
                              ),
                              Image(
                                image: NetworkImage(data[paramImage]),
                                height: 100.0,
                                width: 100.0,
                              ),
                              CustomAlignmnet(
                                  Alignment.bottomLeft,
                                  const Chip(
                                    label: Text(newArrival),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[paramProductBrand],style: kSemiBoldGreyStyle),
                          SizedBox(height: 5.0),
                          Text(data[paramProductName],style: kBoldBlackStyle),
                          SizedBox(height: 5.0),
                          Text('\$${data[paramProductPrice]}',style: kTextGreyStyle)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
