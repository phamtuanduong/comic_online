import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:http/http.dart' as http;

class ChangePassServices {
  Future<bool> change(String password) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/change_password.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "password": password,
        }));

    print(response.body);

    bool check = response.statusCode == 200 &&
        response.body != "DATA_ERROR" &&
        response.body != "TK_KHONG_HOP_LE" &&
        response.body != "TOKEN_KHONG_HOP_LE" &&
        response.body != "KHONG_THANH_CONG";

    return check;
  }
}
