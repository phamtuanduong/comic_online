import 'package:comic_online/models/truyen_chapter.dart';

class Global {
  static String baseApiUri = "http://192.168.1.3/ComicOnlineService/";
  static String getData = "https://hitruyen.vip/";

  static Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static String token = "guest";

  static List<TruyenChapter>? listChapter;

  static bool isLogin() {
    return token != "";
  }
}
