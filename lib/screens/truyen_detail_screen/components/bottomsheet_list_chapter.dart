import 'package:comic_online/controllers/truyen_controllers/truyen_show_all_chap_controller.dart';
import 'package:comic_online/models/truyen_chapter.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetListChapter extends StatelessWidget {
  const BottomSheetListChapter({Key? key, required this.listChapter})
      : super(key: key);
  final List<TruyenChapter> listChapter;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TruyenShowAllChapController>(
      init: TruyenShowAllChapController(listChapter),
      builder: (_controller) => Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            right: 10,
            bottom: 10),
        child: Column(
          children: [
            Container(
              height: 3,
              width: 50,
              decoration: const BoxDecoration(
                  color: menuUnselectedColor,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
            ),
            const SizedBox(width: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tất cả chương", style: textStyleSearch),
                Row(
                  children: [
                    Tooltip(
                      message: "Đảo danh sách",
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Material(
                          child: IconButton(
                              onPressed: () {
                                _controller.reveresList();
                              },
                              icon: const Icon(Icons.change_circle_rounded,
                                  color: menuUnselectedColor)),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Material(
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.close_rounded,
                                color: menuUnselectedColor)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: listChapter.length,
              itemBuilder: (_, i) => Container(
                height: 45,
                child: TextButton(
                  onPressed: () {},
                  child: Text(_controller.listChapters[i].getNameUpcase(),
                      style: textDetailDsChapStyle.copyWith(fontSize: 14)),
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                ),
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
              ),
            ))
          ],
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      ),
    );
  }
}
