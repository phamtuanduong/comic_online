import 'dart:convert';

import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/models/truyen_model.dart';
import 'package:http/http.dart' as http;

class GetTruyenServices {
  Future<List<TruyenModel>> fetchData({int count = 20}) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/get_books.php");
    //print("object");
    http.Response response = await http.post(
      uri,
      headers: Global.headers,
      body: json.encode({
        'token': Global.token,
        'page': '1',
        'pageCount': count,
      }),
    );

    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);

      var list = listJson.map((e) => TruyenModel.fromMap(e)).toList();
      //print(list.first);
      if (list.isNotEmpty) {
        return list;
      }
    } else {
      return [];
    }

    return [];
  }

  Future resetRateBook(TruyenModel truyenModel) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/get_rate_book.php");
    //print("object");
    http.Response response = await http.post(
      uri,
      headers: Global.headers,
      body: json.encode({
        'token': Global.token,
        'bookID': truyenModel.id,
      }),
    );
    //print(response.body);
    if (response.statusCode == 200 &&
        response.body != "DATA_ERROR" &&
        response.body != "KHONG_THANH_CONG") {
      List<dynamic> listJson = json.decode(response.body);

      truyenModel.rate = double.parse(listJson.first["rate"].toString());
      truyenModel.rateCount = listJson.first["rateCount"];
    }
  }

  Future layDanhGia(TruyenModel truyenModel) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/get_review_book.php");
    //print("object");
    http.Response response = await http.post(
      uri,
      headers: Global.headers,
      body: json.encode({
        'token': Global.token,
        'bookID': truyenModel.id,
      }),
    );
    //print(response.body);
    if (response.statusCode == 200 &&
        response.body.trim() != "DATA_ERROR" &&
        response.body != "KHONG_THANH_CONG") {
      List<dynamic> listJson = json.decode(response.body);

      ReviewBookModel? reviewBookModel =
          ReviewBookModel.fromMap(listJson.first);

      truyenModel.reviewBookModel = reviewBookModel;
    }
  }

  Future<List<TruyenModel>> fetchDataMore(int start, int count) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/get_books.php");
    http.Response response = await http.post(
      uri,
      headers: Global.headers,
      body: json.encode({
        'token': Global.token,
        'startRow': start,
        'pageCount': count,
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
