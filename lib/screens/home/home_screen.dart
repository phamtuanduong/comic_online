import 'package:comic_online/controllers/home_controller.dart';
import 'package:comic_online/screens/pages/page.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_controller) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: CustomAppBar(),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white10,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller.tabController,
              children: const [
                TruyenPage(),
                EmptyPage(),
                EmptyPage(),
                EmptyPage()
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: CustomBottomNav(controller: _controller),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, -1), blurRadius: 5)
              ],
              border: Border(
                  top: BorderSide(
                      color: menuUnselectedColor.withOpacity(0.05)))),
        ),
      ),
    );
  }
}
