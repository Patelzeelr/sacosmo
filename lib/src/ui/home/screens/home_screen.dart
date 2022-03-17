import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/container_list.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_card.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_card_category.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_padding.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_popular_list.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_image_container.dart';
import 'package:flutter/material.dart';
import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            CustomImageContainer(),
            const SizedBox(height: 20.0,),
            CustomPadding(arrivals,Alignment.bottomLeft,kHomeTextHeadingStyle),
            const SizedBox(height: 10.0,),
            ContainerList(CustomCard(),100.0,0.42),
            CustomPadding(category,Alignment.bottomLeft,kHomeTextHeadingStyle),
            const SizedBox(height: 10.0,),
            ContainerList(CustomCategoryCard(),100.0,0.15),
            const SizedBox(height: 10.0,),
            CustomPadding(popular,Alignment.bottomLeft,kHomeTextHeadingStyle),
            CustomPopularList(),
          ],
        ),
      ),
    );
  }
}

