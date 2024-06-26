import 'package:comic_online/controllers/home_controller.dart';
import 'package:comic_online/models/truyen_chapter.dart';
import 'package:comic_online/services/login_services/get_login_service.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';

class Global {
  // static String baseApiUri = "http://192.168.0.108/ComicOnlineService/";
  static String baseApiUri = "http://14.183.37.75:88/ComicOnlineService/";
  static String getData = "https://hitruyen.vip/";

  static Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static String token = "guest";

  static List<TruyenChapter>? listChapter;

  static Future<bool> isLogin() async {
    if (token == "guest") {
      if (await GetLoginService().fetchData("guest", "")) {
        SharedPreferenceData.instance.setToken(token);
      }
    }
    return token != "";
  }

  static HomeController? controller;
}
