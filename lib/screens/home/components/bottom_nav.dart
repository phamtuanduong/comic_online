import 'package:flutter/material.dart';

import 'package:comic_online/controllers/home_controller.dart';
import 'package:comic_online/style/style.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: menuUnselectedColor,
      currentIndex: controller.selectIndex,
      onTap: (index) {
        controller.changeIndex(index);
      },
      selectedFontSize: 12.0,
      unselectedFontSize: 12.0,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/menu-truyen.png',
            height: 32,
            width: 32,
          ),
          label: "Truyện",
          activeIcon: Image.asset(
            'assets/images/menu-truyen-active.png',
            height: 32,
            width: 32,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/menu-tieuthuyet.png',
            height: 32,
            width: 32,
          ),
          label: "Lịch sử",
          activeIcon: Image.asset(
            'assets/images/menu-tieuthuyet-active.png',
            height: 32,
            width: 32,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/menu-theodoi.png',
            height: 32,
            width: 32,
          ),
          label: "Theo dõi",
          activeIcon: Image.asset(
            'assets/images/menu-theodoi-active.png',
            height: 32,
            width: 32,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/menu-taikhoan.png',
            height: 32,
            width: 32,
          ),
          label: "Tài khoản",
          activeIcon: Image.asset(
            'assets/images/menu-taikhoan-active.png',
            height: 32,
            width: 32,
          ),
        )
      ],
    );
  }
}
