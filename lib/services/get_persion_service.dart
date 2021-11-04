import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:http/http.dart' as http;

class GetPersionService {
  Future<PersionModel?> fetchData() async {
    Uri uri = Uri.parse("${Global.baseApiUri}/get_persion.php");
    PersionModel? persionModel;
    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "ID": true,
        }));
    bool check = response.statusCode == 200 &&
        response.body != "DATA_ERROR" &&
        response.body != "TK_KHONG_HOP_LE" &&
        response.body != "TOKEN_KHONG_HOP_LE";

    if (check) {
      List<dynamic> data = json.decode(response.body);
      persionModel = PersionModel.fromMap(data.first);
    } else {
      return null;
    }
    return persionModel;
  }
}
