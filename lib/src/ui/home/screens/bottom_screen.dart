import 'package:cosmo_beauty/src/base/constants/icons_constant.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/color_constant.dart';
import '../../../base/constants/strings_constant.dart';
import 'category_screen.dart';
import 'home_screen.dart';
import 'screen_brand.dart';
import 'userprofile_screen.dart';
import 'wishlist_screen.dart';

class BottomScreen extends StatefulWidget{

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int _selectedIndex = 0;

  final _pages = [
    HomeScreen(),
    CategoryScreen(),
    ScreenBrand(),
    WishListScreen(),
    UserProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _bottomBar(),
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
            icon: Icon(iconHome),
            label: home,
          ),
          BottomNavigationBarItem(
            icon: Icon(iconCategory),
            label: category,
          ),
          BottomNavigationBarItem(
            icon: Icon(iconBrand),
            label: brand,
          ),
          BottomNavigationBarItem(
            icon: Icon(iconWishlist),
            label: wishlist,
          ),
          BottomNavigationBarItem(
            icon: Icon(iconUserProfile),
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





