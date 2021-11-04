import 'package:comic_online/models/models.dart';
import 'package:comic_online/services/truyen_services/get_all_comment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentParentDetailPageController extends GetxController
    with SingleGetTickerProviderMixin {
  late TruyenModel _truyenModel;

  CommentParentDetailPageController(TruyenModel truyenModel) {
    _truyenModel = truyenModel;
  }

  @override
  void onInit() async {
    super.onInit();

    Future<List<CommentModel>> _futureOfListCommentsParentDetailPage =
        GetCommentParentServices().fetchData(_truyenModel.id);

    await Future.delayed(const Duration(milliseconds: 100));

    _futureOfListCommentsParentDetailPage
        .then((listResultCommentParentDetailPage) => {
              if (listResultCommentParentDetailPage.isNotEmpty)
                {
                  _truyenModel.listCommentsParent =
                      listResultCommentParentDetailPage.toList(),
                  update(),
                }
            });
  }

  void back(BuildContext context) {
    Navigator.pop(context);
  }
}
