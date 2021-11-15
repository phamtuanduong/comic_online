import 'dart:convert';

import 'package:comic_online/models/models.dart';
import 'package:comic_online/global.dart';
import 'package:http/http.dart' as http;

class ReviewBookService {
  Future<bool> postData(TruyenModel truyenModel, int rate,
      {String action = "ADD"}) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/review_book.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "action": action,
          "bookID": truyenModel.id,
          "rate": rate
        }));

    if (response.statusCode != 200 && response.body == "KHONG_THANH_CONG") {
      return false;
    }
    return true;
  }

  Future<bool> update(TruyenModel truyenModel, int rate,
      {String action = "UPDATE"}) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/review_book.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "action": action,
          "bookID": truyenModel.id,
          "rate": rate
        }));
    // print(response.body);
    if (response.statusCode != 200 && response.body == "KHONG_THANH_CONG") {
      return false;
    }
    return true;
  }
}
