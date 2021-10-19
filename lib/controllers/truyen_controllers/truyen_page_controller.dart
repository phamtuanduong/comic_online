import 'package:comic_online/models/truyen_model.dart';
import 'package:comic_online/services/truyen_services/get_truyen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TruyenPageController extends GetxController {
  late List<TruyenModel> listTruyen = [];
  late ScrollController scrollController;
  late bool isLoad = true;
  @override
  void onInit() async {
    super.onInit();
    scrollController = ScrollController();
  }

  Future loadBook() async {
    Future<List<TruyenModel>> _futureOfList =
        GetTruyenServices().fetchDataMore(listTruyen.length + 1, 10);
    var list = await _futureOfList;
    if (list.isNotEmpty) {
      listTruyen.addAll(list);
      update();
    }

    await Future.delayed(const Duration(milliseconds: 5000));
    isLoad = true;
  }

  Future refeshBook() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    listTruyen.clear();

    Future<List<TruyenModel>> _futureOfList = GetTruyenServices().fetchData();
    listTruyen = await _futureOfList;
    if (listTruyen.isNotEmpty) {
      update();
    }
  }

  @override
  void onReady() async {
    super.onReady();
    scrollController.dispose();
    scrollController = ScrollController();
    Future<List<TruyenModel>> _futureOfList = GetTruyenServices().fetchData();
    listTruyen = await _futureOfList;
    if (listTruyen.isNotEmpty) {
      update();
    }
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent -
                  scrollController.position.pixels <=
              250 &&
          isLoad) {
        isLoad = false;
        await loadBook();
      }
    });
  }
}
