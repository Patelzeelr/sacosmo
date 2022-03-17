import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/param_constant.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_alignment.dart';
import 'package:flutter/material.dart';

class CustomKylie extends StatelessWidget {
  final Stream<QuerySnapshot> popularItems = FirebaseFirestore.instance.collection('kylie').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: popularItems,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          final data = snapshot.requireData;
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.size,
              itemBuilder: (context, i) => Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    //height: MediaQuery.of(context).size.height * 0.26,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      children: [
                        Container(
                          height: 210.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: white,
                            boxShadow: [
                              BoxShadow(color: Color(0xFF865747), spreadRadius: 1, blurRadius: 3),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Align(alignment: Alignment.topRight,child: Icon(Icons.favorite_border)),
                                Expanded(child: Image(image: NetworkImage(data.docs[i][paramImage]),height: 100.0,width: 100.0,)),
                                CustomAlignmnet(Alignment.bottomLeft, Text(data.docs[i][paramProductName])),
                                CustomAlignmnet(Alignment.bottomLeft, Text(data.docs[i][paramProductPrice]))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          );
        }
    );
  }
}