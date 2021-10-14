import 'package:comic_online/global.dart';
import 'package:comic_online/models/truyen_chapter.dart';
import 'package:comic_online/models/truyen_image.dart';
import 'package:comic_online/services/truyen_services/get_truyen_chapter_service.dart';
import 'package:comic_online/services/truyen_services/get_truyen_image.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
  void onInit() {
    super.onInit();

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

    if (Global.listChapter != null) {
      listChapter = Global.listChapter!;
    } else {
      Future<List<TruyenChapter>> _futureOfList =
          GetTruyenChapterService().fetchData(_truyenChapter.bookID);
      _futureOfList.then((listResult) => {
            if (listResult.isNotEmpty)
              {
                Global.listChapter = listResult,
                listChapter = listResult.toList(),
              }
          });
    }

    loadImg(_truyenChapter);
  }

  void nextChap() {
    int nextIndex = listChapter.indexOf(buildReadView.last);

    if (nextIndex > 0 && (listChapter.length > nextIndex + 1)) {
      TruyenChapter nextChap = listChapter[nextIndex + 1];
      loadImg(nextChap);
    } else {
      isEndChap = true;
      update();
    }
  }

  void loadImg(TruyenChapter truyenChapter) {
    Future<List<TruyenImgModel>> _futureOfList =
        GetTruyenImgService().fetchData(truyenChapter.id);

    _futureOfList.then((listResult) => {
          if (listResult.isNotEmpty)
            {
              truyenChapter.listImg = listResult,
              title = truyenChapter.getNameUpcase(),
              buildReadView.add(truyenChapter),
              isLoad = true,
              update(),
              if (buildReadView.length < 2)
                {
                  menuAnimationController.reverse(),
                  isShowAction = true,
                }
            }
        });
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
    Global.listChapter!.clear();
    Global.listChapter = null;
    Navigator.pop(context);
  }

  @override
  void onClose() {
    menuAnimationController.dispose();
    super.onClose();
  }
}
