import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/pages/beranda.dart';
import 'package:pakar_hati/pages/history.dart';
import 'package:pakar_hati/pages/profile.dart';
import 'package:pakar_hati/theme/color.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List pages = [const Beranda(), const History(), const ProfilePage()];

  int currenIndex = 0;
  void onTap(int index) {
    setState(() {
      currenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currenIndex],
      bottomNavigationBar: CurvedNavigationBar(
          index: currenIndex,
          backgroundColor: backgroundColor,
          buttonBackgroundColor: thirdColor,
          color: thirdColor,
          animationDuration: const Duration(milliseconds: 300),
          height: 70,
          onTap: onTap,
          items: const [
            Icon(
              BoxIcons.bxs_home,
              color: primaryTextColor,
            ),
            Icon(
              BoxIcons.bx_history,
              color: primaryTextColor,
            ),
            Icon(
              BoxIcons.bxs_cog,
              color: primaryTextColor,
            ),
          ]),
    );
  }
}
