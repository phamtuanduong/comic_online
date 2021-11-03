import 'dart:convert';

import 'package:comic_online/models/models.dart';
import 'package:comic_online/global.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  Future<bool> checkUsername(AccountModel account) async {
    Uri uri =
        Uri.parse("${Global.baseApiUri}/users/check_username_account.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "username": account.username,
        }));

    if (response.statusCode == 200 && response.body == "NO") {
      return false;
    }
    return true;
  }

  Future<bool> register(AccountModel account) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/persion.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "action": "ADD",
          "FullName": "Không xác định",
          "Email": account.email,
          "Gender": 1,
          "BirthDate": "NULL"
        }));

    if (response.statusCode != 200 && response.body == "KHONG_THANH_CONG") {
      return false;
    }
    return await _registerAccount(account);
  }

  Future<bool> _registerAccount(AccountModel account) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/register.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "user": account.username,
          "pass": account.password,
        }));

    if (response.statusCode == 200 && response.body != "KHONG_THANH_CONG") {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(json.decode(response.body));

      Global.token = data['token'];
    } else {
      return false;
    }
    return true;
  }

  Future<bool> updateInfo(PersionModel persionModel) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/persion.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "action": "UPDATE",
          "FullName": persionModel.fullname,
          "Email": persionModel.email,
          "Gender": persionModel.gender,
          "BirthDate": persionModel.birthdate
        }));

    if (response.statusCode != 200 && response.body == "KHONG_THANH_CONG") {
      return false;
    }
    return true;
  }
}
