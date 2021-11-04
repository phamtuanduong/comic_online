import 'package:comic_online/models/models.dart';
import 'package:comic_online/services/action_services/search_service.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ViewSearchController extends GetxController {
  List<TruyenModel> listTruyen = [];
  late TextEditingController textEditingController;

  late ScrollController scrollController;

  late List<String> listHisSearch;

  bool isLoad = false;

  bool isEnd = false;

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    listHisSearch = SharedPreferenceData.instance.getListHistorySearch();

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
  }

  Future search() async {
    listTruyen.clear();
    String str = textEditingController.text;
    if (str != "") {
      await SharedPreferenceData.instance.saveHisSearch(str);
      listTruyen = await SearchServices().fetchData(str);
      update();
    }
  }

  Future loadMore() async {
    String str = textEditingController.text;
    if (str != "") {
      await SharedPreferenceData.instance.saveHisSearch(str);
      var list =
          await SearchServices().fetchDataMore(str, listTruyen.length + 1, 10);
      if (list.isNotEmpty) {
        listTruyen.addAll(list);
        update();
      } else {
        isEnd = true;
      }
      isLoad = false;
    }
  }

  double getSize() {
    if (listHisSearch.length < 3) {
      return 75;
    } else if (listHisSearch.length > 5) {
      return 120;
    }

    return 120;
  }

  void changeSearch(int i) {
    textEditingController.text = listHisSearch[i];
    update();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
