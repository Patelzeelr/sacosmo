import 'package:cosmo_beauty/src/ui/home/constants/string_constant.dart';
import 'package:flutter/cupertino.dart';

class CustomPadding extends StatelessWidget{
  CustomPadding(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(label,style: kTextBoldStyle)
      ),
    );
  }

}