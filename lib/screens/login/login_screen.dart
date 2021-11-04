import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/login_controllers/login_controller.dart';
import 'package:comic_online/screens/login/register_screen.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, this.isBack = false}) : super(key: key);
  final bool isBack;
  @override
  Widget build(BuildContext context) {
    Size _size = Get.mediaQuery.size;
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: SafeArea(
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (_controller) => Column(
            children: [
              Stack(children: [
                Image.asset(
                  'assets/images/header_login_bg.png',
                  height: _size.height * 0.2,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                isBack
                    ? Positioned(
                        child: ButtomBack(
                        iconColor: Colors.white,
                        onClick: () {
                          Get.back();
                        },
                      ))
                    : const SizedBox()
              ]),
              SizedBox(
                child: Stack(alignment: Alignment.center, children: [
                  Image.asset(
                    'assets/images/background_logo.png',
                    color: primaryColor,
                    height: 80,
                  ),
                  Text(
                    "TRUYỆN TRANH\nONLINE",
                    textAlign: TextAlign.center,
                    style: textDetailStyle.copyWith(
                        fontSize: 15, color: Colors.cyan),
                  )
                ]),
              ),
              const SizedBox(height: defaultPadding * 2),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Container(
                  margin: const EdgeInsets.all(defaultPadding / 2),
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  width: double.infinity,
                  height: _size.height * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: defaultPadding / 4),
                      Text(
                        "Xin chào",
                        style: textDetailStyle.copyWith(
                            color: primaryColor, fontSize: 20),
                      ),
                      const SizedBox(height: defaultPadding / 4),
                      const Text(
                        "Đăng nhập tài khoản của bạn",
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
                      Expanded(
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              bool flag = await _controller.login();
                              if (!flag) {
                                Get.snackbar("Đăng nhập không thành công",
                                    "Sai toàn khoản hoặc mật khẩu",
                                    icon: const Icon(Icons.error),
                                    backgroundColor: Colors.white54);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: _controller.isLogin
                                  ? MainAxisAlignment.spaceEvenly
                                  : MainAxisAlignment.center,
                              children: [
                                Text("ĐĂNG NHẬP", style: textDetailStyle),
                                _controller.isLogin
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
                    "Bạn chưa có tài khoản?",
                    style: textSubStyle,
                  ),
                  const SizedBox(width: defaultPadding / 4),
                  InkWell(
                    onTap: () {
                      Get.to(const RegisterScreen(),
                          transition: Transition.rightToLeftWithFade);
                    },
                    child: Text("Đăng ký ngay", style: textDetailButtonStyle),
                  ),
                  Text(
                    " hoặc ",
                    style: textSubStyle,
                  ),
                  InkWell(
                    onTap: () {
                      _controller.useGuest();
                    },
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
