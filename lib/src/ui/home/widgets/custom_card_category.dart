import 'package:cosmo_beauty/src/base/constants/image_constant.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import '../screens/facecategory_screen.dart';

class CustomCardCategory {
  CustomCardCategory(this.color,this.images);

  final Color color;
  final String images;
}
List<CustomCardCategory> categoryData = [

  CustomCardCategory(skin, imageFace),
  CustomCardCategory(babyPink, imageLip),
  CustomCardCategory(nude, imageEye),
  CustomCardCategory(lightPink, imageNail),

  ];
class CustomCategoryCard extends StatelessWidget{
  List _list = [face,lip,eye,nail];

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryData.length,
              itemBuilder: (context,i) => GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FaceCategoryScreen(value: _list[i])
                  ));
                },
                child: Card(
                elevation: 3,
                color: categoryData[i].color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Image.asset(categoryData[i].images,),
                ),
            ),
              )
        ),
      );
    }
  }