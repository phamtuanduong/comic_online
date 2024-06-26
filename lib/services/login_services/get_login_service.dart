import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:http/http.dart' as http;

class GetLoginService {
  Future<bool> fetchData(String user, String pass) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/login.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "username": user,
          "password": pass,
        }));

    if (response.statusCode == 200 &&
        response.body != "SAI_THONG_TIN_DANG_NHAP") {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(json.decode(response.body));

      Global.token = data['token'];
    } else {
      return false;
    }
    return true;
  }

  Future<String> getGuestLogin() async {
    Uri uri = Uri.parse("${Global.baseApiUri}/login.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "username": "guest",
          "password": "",
        }));

    if (response.statusCode == 200 &&
        response.body != "SAI_THONG_TIN_DANG_NHAP") {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(json.decode(response.body));

      Global.token = data['token'];

      await SharedPreferenceData.instance.setFirstUse();
    } else {
      return Global.token;
    }
    return Global.token;
  }
}
