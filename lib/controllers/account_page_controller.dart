import 'package:comic_online/controllers/home_controller.dart';
import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/screens/home/home_screen.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/services/get_persion_service.dart';
import 'package:comic_online/services/login_services/get_login_service.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:get/get.dart';

class AccountPageController extends GetxController {
  late PersionModel persionModel;
  late String username;
  final HomeController controller;

  AccountPageController(this.controller);

  @override
  void onInit() async {
    super.onInit();
    persionModel = PersionModel(id: 0, fullname: "", email: "", gender: 0);
    PersionModel? persion = await GetPersionService().fetchData();

    if (persion != null) {
      persionModel = persion;
      update();
    }
  }

  bool checkLogin() {
    if (persionModel.email == "" ||
        persionModel.email == "guest" ||
        persionModel.email == "none") {
      return false;
    }

    return true;
  }

  void dangXuat() async {
    GetLoginService().getGuestLogin();

    SharedPreferenceData.instance.setToken(Global.token);
    controller.changeIndex(0);
    Get.offAll(const HomeScreen());
  }
}
