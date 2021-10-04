import 'package:comic_online/models/truyen_model.dart';
import 'package:comic_online/services/truyen_services/get_truyen_service.dart';
import 'package:get/get.dart';

class TruyenController extends GetxController {
  late List<TruyenModel> listTruyen = [];

  @override
  void onInit() async {
    super.onInit();

    Future<List<TruyenModel>> _futureOfList = GetTruyenServices().fetchData();
    listTruyen = await _futureOfList;
    if (listTruyen.isNotEmpty) {
      update();
    }
  }
}
