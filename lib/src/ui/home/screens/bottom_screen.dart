import 'package:cosmo_beauty/src/base/constants/color_constant.dart';
import 'package:cosmo_beauty/src/ui/home/screens/brand_screen.dart';
import 'package:cosmo_beauty/src/ui/home/screens/category_screen.dart';
import 'package:cosmo_beauty/src/ui/home/screens/home_screen.dart';
import 'package:cosmo_beauty/src/ui/home/screens/userprofile_screen.dart';
import 'package:cosmo_beauty/src/ui/home/screens/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/constants/strings_constant.dart';

class BottomScreen extends StatefulWidget{

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int _selectedIndex = 0;

  final _pages = [
    HomeScreen(),
    CategoryScreen(),
    BrandScreen(),
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
            icon: Icon(Icons.widgets),
            label: home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: category,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: brand,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: wishlist,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
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





