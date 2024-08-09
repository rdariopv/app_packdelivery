import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: GNav(
          color: Colors.grey[400],
          activeColor: Colors.grey.shade700,
          tabActiveBorder: Border.all(color:Colors.white),
          tabBackgroundColor: Colors.grey.shade100,
          mainAxisAlignment: MainAxisAlignment.center,
          tabBorderRadius: 16,
          gap:8,
          onTabChange: (value) => onTabChange!(value),
          tabs: const [
            GButton(
              icon: FontAwesomeIcons.boxesStacked,
              text: 'Shop 1',
            ),
            GButton(
              icon: Icons.shopping_bag_rounded,
              text: 'Cart 1',
            )
          ],)
    );
  }
}