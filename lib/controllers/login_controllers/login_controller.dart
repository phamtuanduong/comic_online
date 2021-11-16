import 'package:comic_online/global.dart';
import 'package:comic_online/screens/home/home_screen.dart';
import 'package:comic_online/services/login_services/get_login_service.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool isShowPassword = true;
  bool isLogin = false;

  String username = "";
  String password = "";

  String? invalidTextUser;
  String? invalidTextPassword;

  void changeShowHidePass() {
    isShowPassword = !isShowPassword;
    update();
  }

  void useGuest() {
    Global.token = "guest";
    SharedPreferenceData.instance.setToken("guest");
    Get.offAll(const HomeScreen());
  }

  bool invalidUser() {
    if (username == "") {
      invalidTextUser = "Vui lòng nhập tên tài khoản";
      return false;
    }
    invalidTextUser = null;
    return true;
  }

  bool invalidPassword() {
    if (password == "") {
      invalidTextPassword = "Vui lòng nhập mật khẩu";
      return false;
    } else if (password.length < 6) {
      invalidTextPassword = "Mật khẩu ít nhất 6 kí tự";
      return false;
    }
    invalidTextPassword = null;
    return true;
  }

  Future<bool> login() async {
    bool flag = true;

    if (invalidUser() && invalidPassword() && !isLogin) {
      isLogin = true;
      update();

      flag = await GetLoginService().fetchData(username, password);
      await Future.delayed(const Duration(seconds: 1));
      isLogin = false;

      if (flag) {
        SharedPreferenceData.instance.setToken(Global.token);

        if (Global.controller != null) {
          Global.controller!.changeIndex(0);
        }

        Get.to(const HomeScreen());
      } else {
        update();
      }
    } else {
      flag = false;
    }

    return flag;
  }
}
