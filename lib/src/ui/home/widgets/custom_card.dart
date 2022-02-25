import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/ui/home/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CustomCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          //height: MediaQuery.of(context).size.height * 0.26,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: white,
                  boxShadow: [
                    BoxShadow(color: pink, spreadRadius: 0, blurRadius: 3),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(alignment: Alignment.topRight,child: Icon(Icons.favorite_border)),
                      Image(image: AssetImage('assets/images/lip.jpg'),height: 100.0,width: 100.0,),
                      Align(alignment: Alignment.bottomLeft,child: Chip(label: Text('new'),))
                    ],
                  ),
                ),
                ),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Elf'),
                  Text('Magenta Elf Mate Lipstick'),
                  Text('44.99')
                ],
              ),
            ],
          ),
          ),
      ],
    );
  }
}

/*
return Stack(
fit: StackFit.loose,
children: [
Container(
height: MediaQuery.of(context).size.height * 0.3,
width: MediaQuery.of(context).size.width * 0.6,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20),
image: const DecorationImage(
image: AssetImage('assets/images/lip.jpg'),
fit: BoxFit.fitHeight,
),
),
),
Positioned(
left: 0.0,
bottom: 0.0,
child: Chip(
label: Text('new'),)
),
Icon(Icons.favorite_border),
],
);*/
