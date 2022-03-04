import 'package:cosmo_beauty/src/base/constants/image_constant.dart';
import 'package:cosmo_beauty/src/ui/home/screens/facecategory_screen.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_steggered.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/cutom_image_right_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../base/constants/strings_constant.dart';

class CategoryScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              CustomImageRightContainer(),
              StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                children: [
                  CustomSteggered(2, 2, rareFoundation, 'Face',(){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FaceCategoryScreen()
                  ));}),
                  CustomSteggered(2, 3, nailPolish, 'Nail',(){}),
                  CustomSteggered(2, 2.5, kylieLip, 'Lip',(){}),
                  CustomSteggered(2, 2.5, eyeShadow, 'Eye',(){}),
                  _steggeredOther(),
                ],
              ),
            ],
          )
      ),
    );
  }
  Widget _steggeredOther() => StaggeredGridTile.count(
    crossAxisCellCount: 2,
    mainAxisCellCount: 1,
    child: Container(color: const Color(0xFFd0b6a5),child: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
      alignment: Alignment.bottomLeft,
      child: Text('Makeup Kits',style: kTextWhiteStyle,),
      ),
    )),
  );
}