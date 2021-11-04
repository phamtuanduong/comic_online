import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/services/truyen_services/comment_service.dart';
import 'package:comic_online/services/truyen_services/get_all_comment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentChildDetailPageController extends GetxController
    with SingleGetTickerProviderMixin {
  late TruyenModel _truyenModel;
  late int _parentID;
  late TextEditingController textCommentController;

  CommentChildDetailPageController(TruyenModel truyenModel, int parentID) {
    _truyenModel = truyenModel;
    _parentID = parentID;
  }

  @override
  void onInit() async {
    super.onInit();
    textCommentController = TextEditingController();

    Future<List<CommentModel>> _futureOfListCommentChildDetailPage =
        GetCommentChildServices().fetchData(_parentID);

    await Future.delayed(const Duration(milliseconds: 100));

    _futureOfListCommentChildDetailPage
        .then((listResultCommentChildDetailPage) => {
              if (listResultCommentChildDetailPage.isNotEmpty)
                {
                  _truyenModel.listCommentsChild =
                      listResultCommentChildDetailPage.toList(),
                  update(),
                }
            });
  }

  void back(BuildContext context) {
    Navigator.pop(context);
  }

  Future addCommentChildDetailPage(
      int listchapID, String content, int parentID) async {
    if (await Global.isLogin()) {
      if (content != "") {
        bool flag = await CommentService().postData(
            listchapID, content, parentID,
            list: _truyenModel.listCommentsChild);
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
    _truyenModel.listCommentsChild.clear();
    super.onClose();
  }
}
