import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';

class CustomAddressRow extends StatelessWidget{
  CustomAddressRow(this.icons,this.widget);

  final IconData icons;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icons,size: 20,color: grey),
        SizedBox(width: 10.0),
        widget
      ],
    );
  }

}