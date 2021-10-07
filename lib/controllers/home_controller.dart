import 'package:comic_online/screens/pages/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  int selectIndex = 0;

  late TabController tabController;

  List<Widget> buildPages() {
    return const [
      TruyenPage(),
      EmptyPage(),
      EmptyPage(),
      EmptyPage(),
    ];
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: buildPages().length, vsync: this);
  }

  void changeIndex(int index) {
    if (tabController.index != index) {
      tabController.index = index;
      update();
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
