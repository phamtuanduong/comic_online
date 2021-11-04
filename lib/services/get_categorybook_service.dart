import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:http/http.dart' as http;

class GetTheLoaiTruyenService {
  Future<List<TheLoaiTruyenModel>> fetchData() async {
    List<TheLoaiTruyenModel> list = [];
    Uri uri = Uri.parse("${Global.baseApiUri}/get_categorybook.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
        }));

    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);
      list = listJson.map((e) => TheLoaiTruyenModel.fromMap(e)).toList();
    }
    return list;
  }
}
