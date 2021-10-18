import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:comic_online/models/follow_book_model.dart';
import 'package:http/http.dart' as http;

class GetFollowBookService {
  Future<List<FollowBookModel>> fetchData() async {
    List<FollowBookModel> list = [];
    Uri uri = Uri.parse("${Global.baseApiUri}/get_follow_book.php");

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
      List<dynamic> listJson = json.decode(response.body);
      list = listJson.map((e) => FollowBookModel.fromMap(e)).toList();
    }
    return list;
  }
}
