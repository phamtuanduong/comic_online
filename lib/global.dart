import 'package:comic_online/models/truyen_chapter.dart';

class Global {
  static String baseApiUri = "http://192.168.0.108/ComicOnlineService/";
  static String getData = "https://hitruyen.vip/";

  static Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwiaWF0IjoxNjMyODIyNTEwLCJleHBpcmUiOjE2MzI5OTUzMTB9.dIe2SZ4sj3iwUY5FwQyei6V-rD1EbHOfvX1a9Tgr1xQ";

  static List<TruyenChapter>? listChapter;
}
