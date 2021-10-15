import 'package:comic_online/global.dart';
import 'package:comic_online/screens/home/home_screen.dart';
import 'package:comic_online/services/login_services/get_login_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool isShowPassword = true;
  bool isLogin = false;

  String username = "admin";
  String password = "123";

  String? invalidTextUser;
  String? invalidTextPassword;

  void changeShowHidePass() {
    isShowPassword = !isShowPassword;
    update();
  }

  void useGuest() {
    Global.token = "guest";
    Get.to(const HomeScreen());
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
    } else if (password.length < 2) {
      invalidTextPassword = "Mật khẩu ít nhất 6 kí tự";
      return false;
    }
    invalidTextPassword = null;
    return true;
  }

  Future<bool> login() async {
    bool flag = true;

    if (invalidUser() && invalidPassword()) {
      isLogin = true;
      update();

      flag = await GetLoginService().fetchData(username, password);
      await Future.delayed(const Duration(seconds: 1));
      isLogin = false;
    }
    update();
    return flag;
  }
}
