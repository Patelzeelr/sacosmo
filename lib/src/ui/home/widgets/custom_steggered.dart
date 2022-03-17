import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../base/constants/strings_constant.dart';
import '../../../base/constants/textstyle_constant.dart';

class CustomSteggered extends StatelessWidget{

  CustomSteggered(this.crossCount,this.mainCount,this.images,this.label,this.onPressed);

  final int crossCount;
  final double mainCount;
  final String label;
  final String images;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
            crossAxisCellCount: crossCount,
            mainAxisCellCount: mainCount,
            child: Stack(
              children: [
                GestureDetector(onTap: onPressed,child: Image(image: AssetImage(images))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(label,style: kTextWhiteStyle),
                  ),
                )
              ],
            ),
          );
  }

}