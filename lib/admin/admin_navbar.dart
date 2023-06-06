import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/admin/admin_beranda.dart';
import 'package:pakar_hati/admin/admin_history.dart';
import 'package:pakar_hati/admin/admin_profile.dart';
import 'package:pakar_hati/theme/color.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({super.key});

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  List pages = [
    const BerandaAdmin(),
    const AdminHistory(),
    const AdminProfile()
  ];

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
