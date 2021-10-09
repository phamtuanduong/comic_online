import 'package:comic_online/models/truyen_chapter.dart';
import 'package:get/get.dart';

class TruyenShowAllChapController extends GetxController {
  late List<TruyenChapter> listChapters;

  TruyenShowAllChapController(List<TruyenChapter> list) {
    listChapters = list;
  }
  void reveresList() {
    listChapters = listChapters.reversed.toList();
    update();
  }
}
