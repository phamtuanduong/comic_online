import 'package:comic_online/models/models.dart';
import 'package:comic_online/services/login_services/register_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

enum Gender { nu, nam }

class AccChangeInfoController extends GetxController {
  bool isRegisting = false;

  late TextEditingController textFullNameController;
  late TextEditingController textEmailController;

  late Gender gender;

  String? invalidTextFullName;
  String? invalidTextEmail;

  DateTime selectedDate = DateTime(2000);

  late PersionModel persionModel;

  AccChangeInfoController(PersionModel model) {
    persionModel = model;
  }

  @override
  void onInit() {
    super.onInit();

    textFullNameController = TextEditingController();
    textEmailController = TextEditingController(text: persionModel.email);

    if (persionModel.fullname != "Không xác định") {
      textFullNameController.text = persionModel.fullname;
    }

    if (persionModel.gender == 1) {
      gender = Gender.nam;
    } else {
      gender = Gender.nu;
    }

    if (persionModel.birthdate != null && persionModel.birthdate!.length > 5) {
      var date = DateFormat('yyyy-MM-dd').parse(persionModel.birthdate!);
      selectedDate = DateTime.parse(date.toString());
    }
  }

  bool invalidUser() {
    if (textFullNameController.text == "") {
      invalidTextFullName = "Vui lòng nhập tên tài khoản";
      return false;
    }
    invalidTextFullName = null;
    return true;
  }

  bool invalidEmail() {
    if (textEmailController.text == "") {
      invalidTextEmail = "Vui lòng nhập email";
      return false;
    } else if (!textEmailController.text.contains('@')) {
      invalidTextEmail = "Email không đúng định dạng";
      return false;
    }
    invalidTextEmail = null;
    return true;
  }

  String getDateFormat() {
    var outputFormat = DateFormat('dd-MM-yyyy');
    return outputFormat.format(selectedDate);
  }

  String dateFormat(String format) {
    var outputFormat = DateFormat(format);
    return outputFormat.format(selectedDate);
  }

  Future<bool> updateInfo() async {
    bool flag = true;
    bool con = invalidUser() && invalidEmail();

    ///!isRegisting == true, tránh spam nút đăng ký
    if (con && !isRegisting) {
      isRegisting = true;
      update();

      persionModel.fullname = textFullNameController.text;
      persionModel.email = textEmailController.text;
      persionModel.gender = gender.index;
      persionModel.birthdate = dateFormat('yyyy-MM-dd');

      flag = await RegisterService().updateInfo(persionModel);

      await Future.delayed(const Duration(seconds: 1));

      if (flag) {
        isRegisting = false;
      }
    } else {
      flag = false;
    }
    update();

    return flag;
  }

  @override
  void onClose() {
    textFullNameController.dispose();
    textEmailController.dispose();
    super.onClose();
  }
}
