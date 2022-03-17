import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/base/constants/strings_constant.dart';
import 'package:cosmo_beauty/src/ui/home/model/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../base/constants/textstyle_constant.dart';

class NotificationScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: black,),onPressed: (){Navigator.pop(context);}),
        title: Text('Notifications',style: kTextBoldStyle),
      ),
      body: ListView.builder(
        itemCount: notificationData.length,
        itemBuilder: (context, i) {
          return Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            child: Row(
                children: [
                  Image(image: AssetImage(notificationData[i].image),height: 50.0,width: 50.0),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notificationData[i].label,style: kTextBlackBoldStyle),
                      SizedBox(height: 10.0),
                      SizedBox(width:150.0,child: Text(notificationData[i].detail)),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Text('NEW',style: TextStyle(color: Colors.red),),
                          Text(' | '),
                          Text(notificationData[i].time,style: kTextGreyBoldStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ) ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: white,
                boxShadow: [
                  BoxShadow(
                  color: grey.withOpacity(0.2), blurRadius: 8.0),
                ],
              ),
          );
        },
      )
    );
  }

}