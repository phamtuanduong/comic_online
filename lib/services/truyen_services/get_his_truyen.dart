import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:http/http.dart' as http;

class GetHisTruyenService {
  Future<HisTruyenModel?> fetchData(int bookID) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/get_his_book.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "BookID": bookID,
        }));

    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);
      if (listJson.isNotEmpty) {
        return HisTruyenModel.fromMap(listJson.first);
      }
    }
    return null;
  }

  Future<String?> getName(int chapID) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/get_his_book.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "ListChapID": chapID,
        }));

    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      return response.body;
    }
    return null;
  }
}
