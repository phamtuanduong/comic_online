import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/login_controllers/login_controller.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              Image.asset('assets/images/header_login_bg.png'),
              Stack(alignment: Alignment.center, children: [
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
              const SizedBox(height: defaultPadding * 2),
              Container(
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
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Nhập tên tài khoản",
                          hintStyle: textSubStyle,
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: menuUnselectedColor))),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Nhập mật khẩu",
                            hintStyle: textSubStyle,
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: menuUnselectedColor)))),
                    Expanded(
                      child: Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text("ĐĂNG NHẬP", style: textDetailStyle),
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
              const SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "Bạn chưa có tài khoản?",
                      style: textSubStyle,
                    ),
                    const SizedBox(width: defaultPadding / 4),
                    GestureDetector(
                      onTap: () {},
                      child: Text("Đăng ký ngay", style: textDetailButtonStyle),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
