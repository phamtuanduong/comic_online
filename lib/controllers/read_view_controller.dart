import 'package:comic_online/global.dart';
import 'package:comic_online/models/truyen_chapter.dart';
import 'package:comic_online/models/truyen_image.dart';
import 'package:comic_online/services/truyen_services/get_truyen_chapter_service.dart';
import 'package:comic_online/services/truyen_services/get_truyen_image.dart';
import 'package:comic_online/shared/shared_preferences_data.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReadViewController extends GetxController
    with SingleGetTickerProviderMixin {
  late TruyenChapter _truyenChapter;
  late AnimationController menuAnimationController;
  late Animation<double> menuAnimation;
  late ScrollController scrollController;

  late List<TruyenChapter> listChapter;

  List<TruyenChapter> buildReadView = [];

  bool isShowAction = true;

  bool isEndChap = false;

  bool isLoad = true;

  late String title;

  ReadViewController(TruyenChapter chap) {
    _truyenChapter = chap;
    title = chap.getNameUpcase();
  }

  @override
  void onInit() async {
    super.onInit();

    SharedPreferenceData.instance
        .saveReadBook(_truyenChapter.bookID, _truyenChapter.id);

    menuAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    menuAnimation = CurvedAnimation(
      parent: menuAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    scrollController = ScrollController()
      ..addListener(() {
        if (menuAnimation.status == AnimationStatus.completed) {
          menuAnimationController.reverse();
          isShowAction = true;
        }
        if (scrollController.position.pixels <= 0) {
          menuAnimationController.forward();
          isShowAction = false;
        }
        if (scrollController.position.maxScrollExtent -
                    scrollController.position.pixels <=
                100 &&
            isLoad) {
          isLoad = false;
          nextChap();
        }
      });

    menuAnimationController.forward();
    isShowAction = false;
    listChapter = _truyenChapter.truyenModel!.listChapters;

    loadImg(_truyenChapter);
  }

  nextChap() {
    int nextIndex = listChapter.indexOf(buildReadView.last);

    if (nextIndex > 0 && (listChapter.length > nextIndex + 1)) {
      TruyenChapter nextChap = listChapter[nextIndex + 1];
      loadImg(nextChap);
      SharedPreferenceData.instance.saveReadBook(nextChap.bookID, nextChap.id);
    } else {
      isEndChap = true;
      update();
    }
  }

  void loadImg(TruyenChapter truyenChapter) {
    Future<List<TruyenImgModel>> _futureOfList =
        GetTruyenImgService().fetchData(truyenChapter.id);
    buildReadView.add(truyenChapter);
    try {
      _futureOfList.then((listResult) => {
            if (listResult.isNotEmpty)
              {
                truyenChapter.listImg = listResult,
                title = truyenChapter.getNameUpcase(),
                isLoad = true,
                update(),
                if (buildReadView.length < 2)
                  {
                    menuAnimationController.reverse(),
                    isShowAction = true,
                  }
              }
            else
              {
                nextChap(),
              }
          });
    } catch (_) {}
  }

  void showMenuAction() {
    isShowAction = !isShowAction;
    if (!isShowAction) {
      menuAnimationController.forward();
    } else {
      menuAnimationController.reverse();
    }
  }

  void back(BuildContext context) {
    Global.listChapter = null;
    Navigator.pop(context);
  }

  @override
  void onClose() {
    menuAnimationController.dispose();
    super.onClose();
  }
}
