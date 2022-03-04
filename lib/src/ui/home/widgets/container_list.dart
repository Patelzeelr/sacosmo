import 'package:flutter/cupertino.dart';

class ContainerList extends StatelessWidget{
  ContainerList(this.list,this.width,this.height);

  final Widget list;
  final double width;
  final double height;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * width,
        height: size.height * height,
        child: list
    );
  }

}