import 'package:comic_online/services/change_pass_services.dart';
import 'package:get/get.dart';

class AccChangePassController extends GetxController {
  bool isShowPassword = true;
  bool isShowRePassword = true;

  bool isRegisting = false;

  String password = "";
  String rePassword = "";

  String? invalidTextPassword;
  String? invalidTextRePassword;

  void changeShowHidePass() {
    isShowPassword = !isShowPassword;
    update();
  }

  void changeShowHideRePass() {
    isShowRePassword = !isShowRePassword;
    update();
  }

  bool invalidPassword() {
    if (password == "") {
      invalidTextPassword = "Vui lòng nhập mật khẩu";
      return false;
    } else if (password.length < 1) {
      invalidTextPassword = "Mật khẩu ít nhất 6 kí tự";
      return false;
    }
    invalidTextPassword = null;
    return true;
  }

  bool invalidRePassword() {
    if (rePassword == "") {
      invalidTextRePassword = "Vui lòng nhập mật khẩu";
      return false;
    } else if (rePassword.length < 1) {
      invalidTextRePassword = "Mật khẩu ít nhất 6 kí tự";
      return false;
    }
    invalidTextRePassword = null;
    return true;
  }

  bool invalidCheckPassword() {
    if (rePassword != password) {
      invalidTextRePassword = "Mật khẩu không khớp";
      return false;
    }
    invalidTextRePassword = null;
    return true;
  }

  Future change() async {
    bool flag = true;
    bool con =
        invalidPassword() && invalidRePassword() && invalidCheckPassword();

    ///!isRegisting == true, tránh spam nút đăng ký
    if (con && !isRegisting) {
      isRegisting = true;
      update();

      flag = await ChangePassServices().change(password);

      await Future.delayed(const Duration(seconds: 1));

      if (!flag) {
        isRegisting = false;
        update();
      }
    } else {
      flag = false;
      update();
    }

    return flag;
  }
}
