import 'dart:convert';
import 'package:comic_online/global.dart';
import 'package:comic_online/models/comment_model.dart';
import 'package:http/http.dart' as http;

class CommentService {
  Future<bool> postData(int listchapID, String content, int parentID,
      {String action = "ADD", List<CommentModel>? list}) async {
    Uri uri = Uri.parse("${Global.baseApiUri}/users/comments.php");

    http.Response response = await http.post(uri,
        headers: Global.headers,
        body: json.encode({
          "token": Global.token,
          "action": action,
          "ListChapID": listchapID,
          "Content": content,
          "ParentID": parentID
        }));

    if (response.statusCode == 200 && response.body != "KHONG_THANH_CONG") {
      var comment = json.decode(response.body);
      list!.add(CommentModel.fromMap(comment));
    }
    return true;
  }
}
