import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/services/truyen_services/comment_service.dart';
import 'package:comic_online/services/truyen_services/get_all_comment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentChildByChapController extends GetxController
    with SingleGetTickerProviderMixin {
  late TruyenChapter _truyenChapter;
  late int _parentID;
  late TextEditingController textCommentController;

  CommentChildByChapController(TruyenChapter truyenChapter, int parentID) {
    _truyenChapter = truyenChapter;
    _parentID = parentID;
  }

  @override
  void onInit() async {
    super.onInit();
    textCommentController = TextEditingController();

    Future<List<CommentModel>> _futureOfListCommentChildByChap =
        GetCommentChildServices().fetchData(_parentID);

    await Future.delayed(const Duration(milliseconds: 100));

    _futureOfListCommentChildByChap.then((listResultCommentChildByChap) => {
          if (listResultCommentChildByChap.isNotEmpty)
            {
              _truyenChapter.listCommentsChild =
                  listResultCommentChildByChap.toList(),
              update(),
            }
        });
  }

  void back(BuildContext context) {
    Navigator.pop(context);
  }

  Future addCommentChildByChap(
      int listchapID, String content, int parentID) async {
    if (await Global.isLogin()) {
      if (content != "") {
        bool flag = await CommentService().postData(
            listchapID, content, parentID,
            list: _truyenChapter.listCommentsChild);
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

  @override
  void onClose() {
    _truyenChapter.listCommentsChild.clear();
    super.onClose();
  }
}
