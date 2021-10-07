import 'package:comic_online/constants.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/models/truyen_chapter.dart';
import 'package:comic_online/services/truyen_services/get_truyen_chapter_service.dart';
import 'package:comic_online/style/colors.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TruyenDetailController extends GetxController {
  late TruyenModel _truyenModel;

  TruyenDetailController(TruyenModel truyenModel) {
    _truyenModel = truyenModel;
  }

  @override
  void onInit() {
    super.onInit();

    Future<List<TruyenChapter>> _futureOfList =
        GetTruyenChapterService().fetchData(_truyenModel.id);
    _futureOfList.then((listResult) => {
          if (listResult.isNotEmpty)
            {
              _truyenModel.listChapters = listResult.reversed.toList(),
              update(),
            }
        });
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
