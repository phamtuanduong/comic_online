import 'package:comic_online/models/models.dart';
import 'package:comic_online/services/truyen_services/get_all_comment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentController extends GetxController
    with SingleGetTickerProviderMixin {
  late TruyenModel _truyenModel;
  late int _parentID;
  late TextEditingController textCommentController;

  CommentController(TruyenModel truyenModel, int parentID) {
    _truyenModel = truyenModel;
    _parentID = parentID;
  }

  @override
  void onInit() async {
    super.onInit();
    textCommentController = TextEditingController();

    Future<List<CommentModel>> _futureOfListCommentParents =
        GetCommentChildServices().fetchData(_parentID);

    await Future.delayed(const Duration(milliseconds: 100));

    _futureOfListCommentParents.then((listResultCommentChild) => {
          if (listResultCommentChild.isNotEmpty)
            {
              _truyenModel.listCommentsChild = listResultCommentChild.toList(),
              update(),
            }
        });
  }

  void back(BuildContext context) {
    Navigator.pop(context);
  }

  void getText(TextEditingController text) {
    print(text.text);
  }

  List<CommentModel> getListCommentParent() => _truyenModel.listCommentsChild;
}
