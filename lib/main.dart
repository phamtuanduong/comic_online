import 'dart:ui';

import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Comic Online',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: GalleryThemeData.lightThemeData.copyWith(),
      darkTheme: GalleryThemeData.darkThemeData.copyWith(),
      home: const FirstUseScreen(),
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

//Có thể nắm kéo danh sách
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
