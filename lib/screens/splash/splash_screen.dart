import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/splash_controller.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: GetBuilder<SplashController>(
            init: SplashController(),
            builder: (_c) => Center(
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
                ],
              ),
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
