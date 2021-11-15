import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/truyen_controllers/truyen_detail_controller.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetReviewBook extends StatelessWidget {
  const BottomSheetReviewBook({Key? key, required this.controller})
      : super(key: key);
  final TruyenDetailController controller;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TruyenDetailController>(
      init: controller,
      builder: (_) => Container(
        height: Get.mediaQuery.size.height / 3,
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
                const Text("Đánh giá truyện", style: textStyleSearch),
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
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ButtonStar(
                      controller: controller,
                      index: 1,
                    ),
                    _ButtonStar(
                      controller: controller,
                      index: 2,
                    ),
                    _ButtonStar(
                      controller: controller,
                      index: 3,
                    ),
                    _ButtonStar(
                      controller: controller,
                      index: 4,
                    ),
                    _ButtonStar(
                      controller: controller,
                      index: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 45,
                    width: 200,
                    child: TextButton(
                      onPressed: () async {
                        await controller.danhGia();
                      },
                      child: !controller.isReviewBook()
                          ? const Text("Đánh giá")
                          : const Text("Đánh giá lại"),
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: primaryColor,
                          shape: const StadiumBorder()),
                    ))
              ],
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

class _ButtonStar extends StatelessWidget {
  const _ButtonStar({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);
  final TruyenDetailController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.rateBook(index);
      },
      child: Image.asset(
        'assets/images/ic_star.png',
        height: 45,
        color: controller.userRate >= index ? Colors.redAccent : Colors.grey,
      ),
    );
  }
}
