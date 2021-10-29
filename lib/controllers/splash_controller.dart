import 'package:comic_online/global.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Future<bool> checkLogin() async {
    Get.to(const HomeScreen());
    return true;
  }

  @override
  void onReady() async {
    super.onReady();

    await SharedPreferenceData.instance.load();

    bool flag = SharedPreferenceData.instance.firstUse();

    if (!flag) {
      Get.to(const FirstUseScreen());
    } else {
      Global.token = SharedPreferenceData.instance.getToken();
      await Future.delayed(const Duration(milliseconds: 2000));

      if (await Global.isLogin()) {
        Get.offAll(const HomeScreen());
      } else {
        Get.offAll(const LoginScreen());
      }
    }
  }
}
