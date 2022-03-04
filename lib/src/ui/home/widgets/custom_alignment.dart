import 'package:flutter/cupertino.dart';

class CustomAlignmnet extends StatelessWidget{
  CustomAlignmnet(this.align,this.widget);

  final Widget widget;
  final Alignment align;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: widget,
    );
  }

}