import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/base/constants/param_constant.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';

class CustomPopularList extends StatelessWidget{

  final Stream<QuerySnapshot> popularItems = FirebaseFirestore.instance.collection('popularItem').snapshots();

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
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.size,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Image(image: NetworkImage(data.docs[i][paramImage]),height: MediaQuery.of(context).size.height * 0.1,width: MediaQuery.of(context).size.width * 0.1,),
                    SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.docs[i][paramProductName],style: kBoldBlackStyle),
                        SizedBox(height: 2.0),
                        Text(data.docs[i][paramProductPrice],style: kTextBlackStyle),
                        SizedBox(height: 2.0),
                        Text(data.docs[i][paramColor],style: kTextGreyThinStyle),
                      ],
                    ),
                  ],
                ),
              )
          );
        }
    );
  }
}