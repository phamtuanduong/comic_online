import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:comic_online/models/truyen_chapter.dart';
import 'package:http/http.dart' as http;

class GetTruyenChapterService {
  Future<List<TruyenChapter>> fetchData(int bookID) async {
    List<TruyenChapter> list = [];
    Uri uri = Uri.parse("${Global.baseApiUri}/get_list_chapter.php");
    print(Global.token);
    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "BookID": bookID,
        }));

    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);
      list = listJson.map((e) => TruyenChapter.fromMap(e)).toList();
    }
    return list;
  }
}
