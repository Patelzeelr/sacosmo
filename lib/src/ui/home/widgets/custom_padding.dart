import 'package:flutter/cupertino.dart';

class CustomPadding extends StatelessWidget{
  CustomPadding(this.label,this.align,this.style);

  final String label;
  final Alignment align;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Align(
          alignment: align,
          child: Text(label,style: style)
      ),
    );
  }

}