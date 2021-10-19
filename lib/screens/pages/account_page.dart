import 'dart:ui';

import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/account_page_controller.dart';
import 'package:comic_online/screens/login/login_screen.dart';
import 'package:comic_online/style/colors.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountPageController>(
      init: AccountPageController(),
      builder: (_c) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: !_c.checkLogin()
            ? const _GuestView()
            : Column(
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const _Avt(),
                        const SizedBox(width: defaultPadding / 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Xin chào",
                              style:
                                  textDetailButtonStyle.copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: defaultPadding / 4),
                            Text(_c.persionModel.fullname.toUpperCase()),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            bgContent,
                            primaryColor.withOpacity(0.24),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                  ),
                  Expanded(
                      child: Center(
                    child: _ButtomAction(
                      onClick: () {},
                      text: "Thông tin tài khoản",
                      color: primaryColor.withOpacity(0.25),
                    ),
                  )),
                  _ButtomAction(
                    onClick: () {
                      _c.dangXuat();
                    },
                    text: "Đăng xuất",
                    color: primaryColor.withOpacity(0.25),
                  ),
                  const SizedBox(height: defaultPadding / 4)
                ],
              ),
      ),
    );
  }
}

class _ButtomAction extends StatelessWidget {
  const _ButtomAction({
    Key? key,
    required this.text,
    required this.color,
    required this.onClick,
  }) : super(key: key);
  final String text;
  final Color color;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.mediaQuery.size.width * 0.7,
      height: 45,
      child: TextButton(
        onPressed: () {
          onClick();
        },
        child: Text(text, style: textDetailButtonStyle),
        style: TextButton.styleFrom(
            backgroundColor: color, shape: const StadiumBorder()),
      ),
    );
  }
}

class _GuestView extends StatelessWidget {
  const _GuestView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _Avt(
              onClick: () {
                Get.to(const LoginScreen(
                  isBack: true,
                ));
              },
            ),
            const SizedBox(width: defaultPadding / 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tài khoản khách",
                  style: textDetailButtonStyle.copyWith(fontSize: 18),
                ),
                const SizedBox(height: defaultPadding / 4),
                Text(
                  "Nhấn vào ảnh đại diện để đăng nhập",
                  style: textSubStyle,
                ),
              ],
            )
          ],
        ),
        const Expanded(
          child: Center(
            child: Text("Đang xem với chế độ khách,\nmột số chức năng tạm khóa",
                textAlign: TextAlign.center),
          ),
        )
      ],
    );
  }
}

class _Avt extends StatelessWidget {
  const _Avt({
    Key? key,
    this.onClick,
  }) : super(key: key);
  final Function? onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClick != null) {
          onClick!();
        }
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        child: Image.asset('assets/images/guest_icon.png'),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(
            color: menuUnselectedColor,
            width: 4.0,
          ),
        ),
      ),
    );
  }
}
