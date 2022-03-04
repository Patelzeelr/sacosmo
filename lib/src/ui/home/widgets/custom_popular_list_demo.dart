import 'package:flutter/material.dart';

class CustomPopularList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 0.0),
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 100,
      child: ListView.builder(

          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, i) => Row(
            children: [
              Image(image: AssetImage('assets/images/lip.jpg'),height: MediaQuery.of(context).size.height * 0.1,width: MediaQuery.of(context).size.width * 0.1,),
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Estee Foundation'),
                  Text('24.99'),
                  Text('Age: 20 | Color: Unity'),
                ],
              ),
            ],
          )
      ),
    );
  }
}