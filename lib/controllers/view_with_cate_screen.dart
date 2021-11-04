import 'package:comic_online/models/models.dart';
import 'package:comic_online/services/action_services/get_truyen_with_cate_services.dart';
import 'package:comic_online/services/get_categorybook_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewWithCateController extends GetxController {
  int selectIndex = 0;

  List<TheLoaiTruyenModel> listCate = [];
  List<TruyenModel> listTruyen = [];

  late ScrollController scrollController;
  bool isLoad = false;

  bool isEnd = false;

  @override
  void onInit() async {
    super.onInit();
    scrollController = ScrollController();

    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent -
                  scrollController.position.pixels <=
              250 &&
          !isLoad &&
          !isEnd) {
        isLoad = true;
        await loadMore();
      }
    });

    listCate = await GetTheLoaiTruyenService().fetchData();
    listTruyen =
        await GetTruyenWithCateServices().fetchData(listCate[selectIndex].id);
    update();
  }

  Future loadMore() async {
    var list = await GetTruyenWithCateServices()
        .fetchDataMore(listCate[selectIndex].id, listTruyen.length + 1, 10);
    if (list.isNotEmpty) {
      listTruyen.addAll(list);
      update();
    } else {
      isEnd = true;
    }
    isLoad = false;
  }

  bool isSelected(int index) => index == selectIndex;

  Future changeIndex(int i) async {
    isEnd = false;
    selectIndex = i;
    listTruyen.clear();
    listTruyen =
        await GetTruyenWithCateServices().fetchData(listCate[selectIndex].id);
    update();
  }

  @override
  void onClose() {
    listCate.clear();
    scrollController.dispose();
    super.onClose();
  }
}
