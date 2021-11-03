import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/account_info_controllers/account_change_pass_controller.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccChangPassScreen extends StatelessWidget {
  const AccChangPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor.withOpacity(0.12),
        leading: ButtomBack(
          onClick: () {
            Get.back();
          },
        ),
        title: Text(
          "Đổi mật khẩu",
          style: textSubStyle.copyWith(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<AccChangePassController>(
          init: AccChangePassController(),
          builder: (_controller) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
              children: [
                CustomTextField(
                  hintText: "Nhập mật khẩu",
                  invalidText: _controller.invalidTextPassword,
                  isPassword: _controller.isShowPassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controller.changeShowHidePass();
                    },
                    icon: _controller.isShowPassword
                        ? const Icon(Icons.visibility_rounded)
                        : const Icon(Icons.visibility_off_rounded),
                  ),
                  onChanged: (value) {
                    _controller.password = value;
                  },
                ),
                const SizedBox(height: defaultPadding / 2),
                CustomTextField(
                  hintText: "Nhập lại mật khẩu",
                  invalidText: _controller.invalidTextRePassword,
                  isPassword: _controller.isShowRePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controller.changeShowHideRePass();
                    },
                    icon: _controller.isShowRePassword
                        ? const Icon(Icons.visibility_rounded)
                        : const Icon(Icons.visibility_off_rounded),
                  ),
                  onChanged: (value) {
                    _controller.rePassword = value;
                  },
                ),
                const SizedBox(height: defaultPadding),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      bool flag = await _controller.change();
                      if (!flag) {
                        Get.snackbar("Đổi mật khẩu không thành công",
                            "Vui lòng nhập lại thông tin",
                            duration: const Duration(milliseconds: 900),
                            icon: const Icon(Icons.error),
                            backgroundColor: Colors.white54);
                      }
                      if (flag) {
                        Get.snackbar(
                            "Đổi mật khẩu thành công", "Thay đổi thành công",
                            duration: const Duration(milliseconds: 900),
                            icon: const Icon(Icons.error),
                            backgroundColor: Colors.white54,
                            snackbarStatus: (status) {
                          if (status == SnackbarStatus.CLOSED) {
                            Get.back();
                          }
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: _controller.isRegisting
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: [
                        Text("ĐỔI MẬT KHẨU", style: textDetailStyle),
                        _controller.isRegisting
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 3))
                            : const SizedBox(),
                      ],
                    ),
                    style: TextButton.styleFrom(
                        fixedSize: const Size(220, 45),
                        primary: Colors.white,
                        backgroundColor: primaryColor.withOpacity(0.8),
                        shape: const StadiumBorder()),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
