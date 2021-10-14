import 'package:comic_online/constants.dart';
import 'package:comic_online/screens/home/home_screen.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstUseScreen extends StatelessWidget {
  const FirstUseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding * 2),
                Stack(alignment: Alignment.center, children: [
                  Image.asset(
                    'assets/images/background_logo.png',
                    height: 200,
                  ),
                  Text(
                    "TRUYỆN TRANH\nONLINE",
                    textAlign: TextAlign.center,
                    style: textDetailStyle.copyWith(
                      fontSize: 15,
                    ),
                  )
                ]),
                const SizedBox(height: defaultPadding * 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(const LoginScreen());
                      },
                      child: const Text("Đăng nhập"),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: primaryColor,
                          fixedSize: const Size(150, 45),
                          shape: const StadiumBorder()),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Đăng ký",
                        style: TextStyle(color: Colors.teal),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          primary: primaryColor,
                          fixedSize: const Size(150, 45),
                          shape: const StadiumBorder()),
                    )
                  ],
                ),
                const SizedBox(height: defaultPadding * 2),
                TextButton(
                  onPressed: () {
                    Get.to(const HomeScreen());
                  },
                  child: const Text(
                    "Khách",
                    style: TextStyle(color: Color(0xFF414A5B)),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      primary: primaryColor,
                      fixedSize: const Size(200, 45),
                      shape: const StadiumBorder()),
                )
              ],
            ),
          ),
        ),
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF177899), Color(0xFF0CAF9E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
  }
}
