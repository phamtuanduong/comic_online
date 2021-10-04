import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectIndex = 0;

  void changeIndex(int index) {
    if (selectIndex != index) {
      selectIndex = index;
      update();
    }
  }
}
