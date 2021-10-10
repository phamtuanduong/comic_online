import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:comic_online/models/truyen_image.dart';
import 'package:http/http.dart' as http;

class GetTruyenImgService {
  Future<List<TruyenImgModel>> fetchData(int listChapID) async {
    List<TruyenImgModel> list = [];
    Uri uri = Uri.parse("${Global.baseApiUri}/get_list_image.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "ListChapID": listChapID,
        }));

    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);
      list = listJson.map((e) => TruyenImgModel.fromMap(e)).toList();
    }
    return list;
  }
}
