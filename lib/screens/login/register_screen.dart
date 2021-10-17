import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/login_controllers/register_controller.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = Get.mediaQuery.size;
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: SafeArea(
        child: GetBuilder<RegisterController>(
          init: RegisterController(),
          builder: (_controller) => Column(
            children: [
              Stack(children: [
                Image.asset(
                  'assets/images/header_login_bg.png',
                  height: _size.height * 0.2,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                    child: ButtomBack(
                  iconColor: Colors.white,
                  onClick: () {
                    Get.back();
                  },
                ))
              ]),
              const SizedBox(height: defaultPadding / 4),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Container(
                  margin: const EdgeInsets.all(defaultPadding / 2),
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  width: double.infinity,
                  height: _size.height * 0.65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: defaultPadding / 4),
                      Text(
                        "Đăng ký tài khoản",
                        style: textDetailStyle.copyWith(
                            color: primaryColor, fontSize: 20),
                      ),
                      const SizedBox(height: defaultPadding / 4),
                      const Text(
                        "Vui lòng nhập thông tin để tiến hành đăng ký tài khoản",
                        style: textStyleSearch,
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomTextField(
                        hintText: "Nhập tên tài khoản",
                        invalidText: _controller.invalidTextUser,
                        suffixIcon: const Icon(Icons.account_circle_rounded),
                        onChanged: (value) {
                          _controller.username = value;
                        },
                      ),
                      const SizedBox(height: defaultPadding / 2),
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
                      const SizedBox(height: defaultPadding / 2),
                      CustomTextField(
                        hintText: "Nhập email",
                        invalidText: _controller.invalidTextEmail,
                        onChanged: (value) {
                          _controller.email = value;
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              bool flag = await _controller.register();
                              if (!flag) {
                                Get.snackbar("Đăng ký không thành công",
                                    "Vui lòng nhập lại thông tin",
                                    icon: const Icon(Icons.error),
                                    backgroundColor: Colors.white54);
                              }
                              if (flag) {
                                // Get.to(const HomeScreen());
                              }
                            },
                            child: Row(
                              mainAxisAlignment: _controller.isRegisting
                                  ? MainAxisAlignment.spaceEvenly
                                  : MainAxisAlignment.center,
                              children: [
                                Text("ĐĂNG KÝ", style: textDetailStyle),
                                _controller.isRegisting
                                    ? const SizedBox(
                                        height: 22,
                                        width: 22,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3))
                                    : const SizedBox(),
                              ],
                            ),
                            style: TextButton.styleFrom(
                                fixedSize: const Size(220, 45),
                                primary: Colors.white,
                                backgroundColor: primaryColor.withOpacity(0.8),
                                shape: const StadiumBorder()),
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Wrap(
                children: [
                  Text(
                    "Bạn đã có tài khoản?",
                    style: textSubStyle,
                  ),
                  const SizedBox(width: defaultPadding / 4),
                  InkWell(
                    onTap: () {},
                    child: Text("Đăng nhập ngay", style: textDetailButtonStyle),
                  ),
                  Text(
                    " hoặc ",
                    style: textSubStyle,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text("Khách", style: textDetailButtonStyle),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
