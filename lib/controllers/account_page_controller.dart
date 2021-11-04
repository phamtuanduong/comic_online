import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/screens/home/home_screen.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/services/get_persion_service.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:get/get.dart';

class AccountPageController extends GetxController {
  bool checkLogin() => Global.token == "guest" ? false : true;
  late PersionModel persionModel;
  late String username;
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

  void dangXuat() {
    Global.token = "guest";
    SharedPreferenceData.instance.setToken("guest");

    Get.offAll(const HomeScreen());
  }
}
