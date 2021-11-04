
import 'package:comic_online/controllers/truyen_controllers/truyen_detail_controller.dart';

import 'package:comic_online/models/follow_book_model.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/screens/truyen_detail_screen/truyen_detail_screen.dart';
import 'package:comic_online/services/truyen_services/get_follow_book.dart';
import 'package:comic_online/services/truyen_services/get_truyen_chapter_service.dart';
import 'package:comic_online/services/truyen_services/get_truyen_info_services.dart';
import 'package:comic_online/services/truyen_services/get_truyen_service.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';

//import 'package:comic_online/services/truyen_services/get_truyen_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowPageController extends GetxController {
  late List<FollowBookModel> listFollow = [];
  late TruyenModel truyen;
  late ScrollController scrollController;
  late bool isLoad = false;
  @override
  void onInit() async {
    super.onInit();
    scrollController = ScrollController();
  }
  Future loadBook() async {
    Future<List<FollowBookModel>> _futureOfList =
        GetFollowBookService().fetchDatamore(listFollow.length+1, 10);
    var list = await _futureOfList;
    if (list.isNotEmpty) {
      listFollow.addAll(list);
      update();
    }

    await Future.delayed(const Duration(milliseconds: 5000));
    isLoad = true;
  }

  Future refeshBook() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    listFollow.clear();

    Future<List<FollowBookModel>> _futureOfList = GetFollowBookService().fetchData();
    listFollow = await _futureOfList;
    if (listFollow.isNotEmpty) {
      update();
    }
  }
  Future readBookFollow(int bookID) async {
    TruyenModel? truyenModel = await GetTruyenInfoServices().fetchData(bookID);

    if (truyenModel != null) {
      Get.to(TruyenDetailScreen(truyenModel));
    }
  }

    
  @override
  void onReady() async {
    super.onReady();
    scrollController.dispose();
    scrollController = ScrollController();
    Future<List<FollowBookModel>> _futureOfList = GetFollowBookService().fetchData();
    listFollow = await _futureOfList;
    if (listFollow.isNotEmpty) {
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