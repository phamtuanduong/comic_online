import 'dart:convert';
import 'package:comic_online/global.dart';
import 'package:comic_online/models/comment_model.dart';
import 'package:http/http.dart' as http;

class GetCommentParentByChapServices {
  Future<List<CommentModel>> fetchData(int listchapID, {int count = 20}) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/get_comments_parent_by_chap.php");
    // ignore: avoid_print
    print('List Chap ID:' + listchapID.toString());
    http.Response response = await http.post(
      uri,
      headers: Global.headers,
      body: json.encode({
        'token': Global.token,
        'page': '1',
        'pageCount': count,
        'ListChapID': listchapID,
      }),
    );
    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);
      var list = listJson.map((e) => CommentModel.fromMap(e)).toList();
      if (list.isNotEmpty) {
        return list;
      }
    } else {
      return [];
    }

    return [];
  }
}

class GetCommentParentServices {
  Future<List<CommentModel>> fetchData(int bookID, {int count = 20}) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/get_comments_parent.php");

    http.Response response = await http.post(
      uri,
      headers: Global.headers,
      body: json.encode({
        'token': Global.token,
        'page': '1',
        'pageCount': count,
        'BookID': bookID,
      }),
    );
    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);
      var list = listJson.map((e) => CommentModel.fromMap(e)).toList();
      if (list.isNotEmpty) {
        return list;
      }
    } else {
      return [];
    }

    return [];
  }
}

class GetCommentChildServices {
  Future<List<CommentModel>> fetchData(int parentID, {int count = 50}) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/get_comments_child.php");

    http.Response response = await http.post(
      uri,
      headers: Global.headers,
      body: json.encode({
        'token': Global.token,
        'page': '1',
        'pageCount': count,
        'ParentID': parentID,
      }),
    );
    if (response.statusCode == 200 && response.body != "DATA_ERROR") {
      List<dynamic> listJson = json.decode(response.body);
      var list = listJson.map((e) => CommentModel.fromMap(e)).toList();
      if (list.isNotEmpty) {
        return list;
      }
    } else {
      return [];
    }

    return [];
  }
}
