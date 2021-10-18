import 'dart:convert';

import 'package:comic_online/models/models.dart';
import 'package:comic_online/global.dart';
import 'package:http/http.dart' as http;

class FollowService {
  Future<bool> postData(TruyenModel truyenModel,
      {String action = "ADD"}) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/follow_book.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "action": action,
          "BookID": truyenModel.id,
          "LastChap": truyenModel.listChapters.first.id
        }));

    if (response.statusCode != 200 && response.body == "KHONG_THANH_CONG") {
      return false;
    }
    return true;
  }
}
