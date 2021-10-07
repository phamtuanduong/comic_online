import 'package:comic_online/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TruyenDetailController extends GetxController {
  late TruyenModel _truyenModel;

  TruyenDetailController(TruyenModel truyenModel) {
    _truyenModel = truyenModel;
  }

  List<Widget> getRateStar() {
    List<Widget> list = [];
    double size = 28;
    String star = 'assets/images/ic_star.png';
    String hstar = 'assets/images/ic_star_half.png';
    Color color = Colors.yellow;
    double rate = _truyenModel.rate;
    if (rate == 0) {
      list.add(Text("Chưa có đánh giá"));
    } else if (rate < 1.5) {
      list.add(Image.asset(
        star,
        height: size,
        color: color,
      ));
    }

    return list;
  }
}
