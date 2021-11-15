import 'package:comic_online/models/account_model.dart';
import 'package:comic_online/screens/login/login_screen.dart';
import 'package:comic_online/services/login_services/register_services.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  bool isShowPassword = true;
  bool isShowRePassword = true;

  bool isRegisting = false;

  String username = "";
  String password = "";
  String rePassword = "";
  String email = "";

  String? invalidTextUser;
  String? invalidTextPassword;
  String? invalidTextRePassword;
  String? invalidTextEmail;

  final RegisterService _registerService = RegisterService();

  void changeShowHidePass() {
    isShowPassword = !isShowPassword;
    update();
  }

  void changeShowHideRePass() {
    isShowRePassword = !isShowRePassword;
    update();
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

  bool invalidRePassword() {
    if (rePassword == "") {
      invalidTextRePassword = "Vui lòng nhập mật khẩu";
      return false;
    } else if (rePassword.length < 6) {
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

  bool invalidEmail() {
    if (email == "") {
      invalidTextEmail = "Vui lòng nhập email";
      return false;
    } else if (!email.contains('@')) {
      invalidTextEmail = "Email không đúng định dạng";
      return false;
    }
    invalidTextEmail = null;
    return true;
  }

  Future<bool> register() async {
    bool flag = true;
    bool con = invalidUser() &&
        invalidPassword() &&
        invalidRePassword() &&
        invalidCheckPassword() &&
        invalidEmail();

    ///!isRegisting == true, tránh spam nút đăng ký
    if (con && !isRegisting) {
      isRegisting = true;
      update();
      var account =
          AccountModel(username: username, password: password, email: email);
      if (!await _registerService.checkUsername(account)) {
        invalidTextUser = "Tên người dùng đã được sử dụng";
      } else {
        invalidTextUser = null;

        flag = await RegisterService().register(account);

        if (flag) {
          Get.to(const LoginScreen());
        }
      }
      await Future.delayed(const Duration(seconds: 1));
      isRegisting = false;
    }

    update();
    return flag;
  }
}
