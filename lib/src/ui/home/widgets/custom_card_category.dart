import 'package:cosmo_beauty/src/ui/home/constants/color_constant.dart';
import 'package:cosmo_beauty/src/ui/home/constants/image_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardCategory {
  CustomCardCategory(this.color,this.images);

  final Color color;
  final String images;
}
List<CustomCardCategory> categoryData = [

  CustomCardCategory(skin, face),
  CustomCardCategory(babyPink, lip),
  CustomCardCategory(nude, eye),
  CustomCardCategory(lightPink, nail),

  ];
class CustomCategoryCard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryData.length,
              itemBuilder: (context,i) => Card(
              elevation: 3,
              color: categoryData[i].color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(categoryData[i].images,),
              ),
            )
        ),
      );
    }
  }