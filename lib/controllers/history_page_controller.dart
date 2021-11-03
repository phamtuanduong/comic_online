import 'package:comic_online/models/models.dart';
import 'package:comic_online/screens/read_view_screen/read_view_screen.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/services/truyen_services/get_his_truyen.dart';
import 'package:comic_online/services/truyen_services/get_truyen_chapter_service.dart';
import 'package:comic_online/services/truyen_services/get_truyen_info_services.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  List<String> listHis = [];

  List<HisTruyenModel> listHisInfo = [];

  late ScrollController scrollController;

  @override
  void onInit() async {
    super.onInit();
    scrollController = ScrollController();
    listHis = SharedPreferenceData.instance.getListHistoryBook("historyBook");
    if (listHis.isNotEmpty) {
      await getHisInfo();
      update();
    }
  }

  Future getHisInfo() async {
    for (var item in listHis) {
      HisTruyenModel? temp =
          await GetHisTruyenService().fetchData(int.parse(item));
      if (temp != null) {
        temp.bookID = int.parse(item);
        temp.lastNum = getNumInfo(item);
        listHisInfo.add(temp);
      }
    }
  }

  Future readDetail(int bookID) async {
    TruyenModel? truyenModel = await GetTruyenInfoServices().fetchData(bookID);

    if (truyenModel != null) {
      Get.to(TruyenDetailScreen(truyenModel));
    }
  }

  Future read(int bookID, int lastNum) async {
    TruyenModel? truyenModel = await GetTruyenInfoServices().fetchData(bookID);

    if (truyenModel != null) {
      List<TruyenChapter> list =
          await GetTruyenChapterService().fetchData(bookID, model: truyenModel);

      if (list.isNotEmpty) {
        truyenModel.listChapters = list.reversed.toList();
        Get.to(ReadViewScreen(list.singleWhere((e) => e.id == lastNum)));
      }
    }
  }

  int getNumInfo(String bookID) {
    int id = int.parse(
        SharedPreferenceData.instance.getHistoryBook(int.parse(bookID))!);

    return id;
  }
}
