import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/ui/home/constants/color_constant.dart';
import 'package:cosmo_beauty/src/ui/home/constants/string_constant.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_card.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_card_category.dart';
import 'package:cosmo_beauty/src/ui/home/widgets/custom_padding.dart';
import 'package:cosmo_beauty/widgets/custom_image_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: No',
      style: optionStyle,
    ),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomImageContainer(),
            const SizedBox(height: 20.0,),
            CustomPadding(arrivals),
            //Center(child: _widgetOptions.elementAt(_selectedIndex),),
            const SizedBox(height: 10.0,),
            Container(
                width: size.width * 100,
                height: size.height * 0.36,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context,i) => CustomCard()
                ),
              ),
            const SizedBox(height: 10.0,),
            CustomPadding(category),
            const SizedBox(height: 10.0,),
            Container(
              width: size.width * 100,
              height: size.height * 0.15,
              child: CustomCategoryCard(),
            ),
            const SizedBox(height: 10.0,),
            CustomPadding(popular),
          ],
        ),
      ),
      bottomNavigationBar: _bottomBar()
    );
  }
  Widget _bottomBar() => Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      boxShadow: [
        BoxShadow(color: pink, spreadRadius: 0, blurRadius: 5),
      ],
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: wishlist,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: brand,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: account,
          ),
        ],
        unselectedItemColor: grey,
        currentIndex: _selectedIndex,
        selectedItemColor: black,
        onTap: _onItemTapped,
      ),
    ),
  );
}
