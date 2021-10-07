import 'package:fifteenbucks/bottom_navigation_bar/profile/profile_screen.dart';
import 'package:fifteenbucks/styles/colors.dart';
import 'package:flutter/material.dart';

import 'cart_screen/cart_screen.dart';
import 'home_screen/home_screen.dart';
import 'like_product/like_product_screen.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int index = 0;

  List<Widget> _list = [
    HomeScreen(),
    CartScreen(),
    LikeProductScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        showSelectedLabels: false,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: AppConstants().primaryColor,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_shopping_cart,
                color: AppConstants().primaryColor,
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: AppConstants().primaryColor,
              ),
              label: 'Heart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: AppConstants().primaryColor,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
