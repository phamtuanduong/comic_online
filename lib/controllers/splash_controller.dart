import 'package:comic_online/global.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    await SharedPreferenceData.instance.load();
  }

  Future<bool> checkLogin() async {
    Get.to(const HomeScreen());
    return true;
  }

  @override
  void onReady() async {
    super.onReady();
    bool flag = SharedPreferenceData.instance.firstUse();

    if (!flag) {
      Get.to(const FirstUseScreen());
    } else {
      Global.token = SharedPreferenceData.instance.getToken();
      await Future.delayed(const Duration(milliseconds: 2000));

      if (Global.isLogin()) {
        Get.offAll(const HomeScreen());
      } else {
        Get.offAll(const LoginScreen());
      }
    }
  }
}
