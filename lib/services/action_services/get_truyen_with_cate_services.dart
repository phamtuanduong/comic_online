import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:comic_online/models/truyen_model.dart';
import 'package:http/http.dart' as http;

class GetTruyenWithCateServices {
  Future<List<TruyenModel>> fetchData(int id, {int count = 20}) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/get_book_with_cate.php");

    http.Response response = await http.post(
      uri,
      headers: Global.headers,
      body: json.encode({
        'token': Global.token,
        'page': '1',
        'pageCount': count,
        'ID': id,
      }),
    );
    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);

      var list = listJson.map((e) => TruyenModel.fromMap(e)).toList();
      if (list.isNotEmpty) {
        return list;
      }
    } else {
      return [];
    }

    return [];
  }

  Future<List<TruyenModel>> fetchDataMore(int id, int start, int count) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/get_book_with_cate.php");
    http.Response response = await http.post(
      uri,
      headers: Global.headers,
      body: json.encode({
        'token': Global.token,
        'startRow': start,
        'pageCount': count,
        'ID': id
      }),
    );

    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);

      var list = listJson.map((e) => TruyenModel.fromMap(e)).toList();
      if (list.isNotEmpty) {
        return list;
      }
    } else {
      return [];
    }

    return [];
  }
}
