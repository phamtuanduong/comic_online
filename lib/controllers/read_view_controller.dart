import 'package:comic_online/models/truyen_chapter.dart';
import 'package:comic_online/models/truyen_image.dart';
import 'package:comic_online/services/truyen_services/get_truyen_image.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReadViewController extends GetxController
    with SingleGetTickerProviderMixin {
  late TruyenChapter _truyenChapter;
  late AnimationController menuAnimationController;
  late Animation<double> menuAnimation;
  late ScrollController scrollController;

  bool isShowAction = true;

  ReadViewController(TruyenChapter chap) {
    _truyenChapter = chap;
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
      });

    menuAnimationController.forward();
    isShowAction = false;

    Future<List<TruyenImgModel>> _futureOfList =
        GetTruyenImgService().fetchData(_truyenChapter.id);

    _futureOfList.then((listResult) => {
          if (listResult.isNotEmpty)
            {
              _truyenChapter.listImg = listResult,
              update(),
              menuAnimationController.reverse(),
              isShowAction = true
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

  @override
  void onClose() {
    menuAnimationController.dispose();
    super.onClose();
  }
}
