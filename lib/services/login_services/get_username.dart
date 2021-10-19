import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:http/http.dart' as http;

class GetUsernameService {
  Future<String?> fetchData() async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/get_account_username.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
        }));

    bool check = response.statusCode == 200 &&
        response.body != "DATA_ERROR" &&
        response.body != "TK_KHONG_HOP_LE" &&
        response.body != "TOKEN_KHONG_HOP_LE";
    if (check) {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(json.decode(response.body));
      return data['username'];
    }
    return null;
  }
}
