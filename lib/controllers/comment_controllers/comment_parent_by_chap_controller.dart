import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/services/truyen_services/comment_service.dart';
import 'package:comic_online/services/truyen_services/get_all_comment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentParentByChapController extends GetxController
    with SingleGetTickerProviderMixin {
  late TruyenChapter _truyenChapter;
  late TextEditingController textCommentParentController;

  CommentParentByChapController(TruyenChapter truyenChapter) {
    _truyenChapter = truyenChapter;
  }

  @override
  void onInit() async {
    super.onInit();
    textCommentParentController = TextEditingController();

    Future<List<CommentModel>> _futureOfListCommentsParentByChap =
        GetCommentParentServices().fetchData(_truyenChapter.id);

    await Future.delayed(const Duration(milliseconds: 100));

    _futureOfListCommentsParentByChap.then((listResultCommentParentByChap) => {
          if (listResultCommentParentByChap.isNotEmpty)
            {
              _truyenChapter.listCommentsParent =
                  listResultCommentParentByChap.toList(),
              update(),
            }
        });
  }

  void back(BuildContext context) {
    Navigator.pop(context);
  }

  Future addCommentParentByChap(int listchapID, String content) async {
    if (await Global.isLogin()) {
      if (content != "") {
        bool flag = await CommentService().postData(listchapID, content, -1,
            list: _truyenChapter.listCommentsParent);
        if (flag) {
          update();
        }
      } else {
        Get.snackbar("Thao tác thất bại", "Bạn chưa nhập nội dung");
      }
    } else {
      Get.snackbar("Thao tác thất bại", "Bạn chưa đăng nhập");
    }
  }
}
