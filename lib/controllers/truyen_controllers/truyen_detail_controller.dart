import 'package:comic_online/constants.dart';
import 'package:comic_online/global.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/models/truyen_chapter.dart';
import 'package:comic_online/screens/read_view_screen/read_view_screen.dart';
import 'package:comic_online/services/truyen_services/follow_service.dart';
import 'package:comic_online/services/truyen_services/get_all_comment_service.dart';
import 'package:comic_online/services/truyen_services/get_truyen_chapter_service.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:comic_online/style/colors.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TruyenDetailController extends GetxController
    with SingleGetTickerProviderMixin {
  late TruyenModel _truyenModel;

  bool isFollow = false;
  bool isLike = false;
  bool isReaded = false;

  late int maxLine = 5;

  int lastChap = 0;

  TruyenDetailController(TruyenModel truyenModel) {
    _truyenModel = truyenModel;
    isFollow = _truyenModel.isFollow;
  }

  @override
  void onInit() async {
    super.onInit();
    Future<List<TruyenChapter>> _futureOfList = GetTruyenChapterService()
        .fetchData(_truyenModel.id, model: _truyenModel);

    isReaded = SharedPreferenceData.instance.checkHistoryBook(_truyenModel.id);
    if (isReaded) {
      String? temp =
          SharedPreferenceData.instance.getHistoryBook(_truyenModel.id);
      if (temp != null) {
        lastChap = int.parse(temp);
      }
    } else {}

    await Future.delayed(const Duration(milliseconds: 100));

    _futureOfList.then((listResult) => {
          if (listResult.isNotEmpty)
            {
              Global.listChapter = listResult,
              _truyenModel.listChapters = listResult.reversed.toList(),
              update(),
            }
        });

    Future<List<CommentModel>> _futureOfListCommentsParent =
        GetCommentParentServices().fetchData(_truyenModel.id);

    await Future.delayed(const Duration(milliseconds: 100));

    _futureOfListCommentsParent.then((listResultCommentParent) => {
          if (listResultCommentParent.isNotEmpty)
            {
              _truyenModel.listCommentsParent =
                  listResultCommentParent.toList(),
              update(),
            }
        });
  }

  String getNameLastChap() {
    if (!_truyenModel.listChapters.isNotEmpty) {
      return "";
    }

    return _truyenModel.listChapters
        .where((element) => element.id == lastChap)
        .first
        .getNameUpcase()
        .split(" - ")[1];
  }

  void docTiep() {
    TruyenChapter truyenChapter = _truyenModel.listChapters
        .where((element) => element.id == lastChap)
        .first;
    Get.to(ReadViewScreen(truyenChapter));
  }

  void viewDesMore(int line) {
    if (line == maxLine) {
      maxLine = 5;
    } else {
      maxLine = line;
    }
    update();
  }

  List<Widget> getRateStar() {
    List<Widget> list = [];
    double size = 22;

    String hstar = 'assets/images/ic_star_half.png';
    Color color = primaryColor;
    double rate = _truyenModel.rate;

    if (rate == 0) {
      list.add(const Text(
        "Chưa có đánh giá",
        style: textStyleSearch,
        overflow: TextOverflow.ellipsis,
      ));
      return list;
    }

    if (rate >= 5) {
      list.addAll(_buildListStar(5, size, color));
    } else if (rate >= 4.5) {
      list.addAll(_buildListStar(4, size, color));
      list.add(Image.asset(
        hstar,
        height: size,
      ));
    } else if (rate >= 4) {
      list.addAll(_buildListStar(4, size, color));
    } else if (rate >= 3.5) {
      list.addAll(_buildListStar(3, size, color));
      list.add(Image.asset(
        hstar,
        height: size,
      ));
    } else if (rate >= 3) {
      list.addAll(_buildListStar(3, size, color));
    } else if (rate >= 2.5) {
      list.addAll(_buildListStar(2, size, color));
      list.add(Image.asset(
        hstar,
        height: size,
      ));
    } else if (rate >= 2) {
      list.addAll(_buildListStar(2, size, color));
    } else if (rate >= 1.5) {
      list.addAll(_buildListStar(1, size, color));
      list.add(Image.asset(
        hstar,
        height: size,
      ));
    } else if (rate >= 1) {
      list.addAll(_buildListStar(1, size, color));
    } else {
      list.add(Image.asset(
        hstar,
        height: size,
      ));
    }

    list.addAll(_buildListStar((5 - rate).toInt(), size, menuUnselectedColor));

    return list;
  }

  List<Widget> _buildListStar(int count, double size, Color color) {
    List<Widget> list = [];
    String star = 'assets/images/ic_star.png';
    for (int i = 1; i <= count; i++) {
      list.add(Image.asset(
        star,
        height: size,
        color: color,
      ));
    }
    return list;
  }

  Future showListChapter(BuildContext context, Widget child) async {
    Get.bottomSheet(child, isScrollControlled: true, ignoreSafeArea: true);
  }

  Future<bool> followBook() async {
    if (!isFollow) {
      if (await Global.isLogin()) {
        isFollow = await FollowService().postData(_truyenModel);
      } else {
        Get.snackbar("Thao tác thất bại", "Bạn chưa đăng nhập");
      }
    } else {
      _truyenModel.followBook = null;
      isFollow =
          !await FollowService().postData(_truyenModel, action: "delete");
    }
    _truyenModel.isFollow = isFollow;
    update();
    return isFollow;
  }

  List<TruyenChapter> getListChap() => _truyenModel.listChapters;

  void readChapFirst() {
    Get.to(ReadViewScreen(
        _truyenModel.listChapters[_truyenModel.listChapters.length - 2]));
  }
}
