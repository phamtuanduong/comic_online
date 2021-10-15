import 'package:comic_online/global.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AccountPageController extends GetxController {
  bool checkLogin() => Global.token == "guest" ? false : true;
}
