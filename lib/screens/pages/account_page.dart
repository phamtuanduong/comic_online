import 'dart:ui';

import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/account_page_controller.dart';
import 'package:comic_online/screens/login/login_screen.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
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
        padding: const EdgeInsets.all(8.0),
        child: _c.checkLogin()
            ? const _GuestView()
            : Column(
                children: [
                  Row(
                    children: [
                      const _Avt(),
                      Text("PHẠM TUÂN DUONG"),
                    ],
                  )
                ],
              ),
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
                Get.to(const LoginScreen());
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
        onClick!();
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
