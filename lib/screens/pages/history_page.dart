import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/history_page_controller.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      init: HistoryController(),
      builder: (_controller) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 3,
              mainAxisExtent: 236,
            ),
            controller: _controller.scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: _controller.listHisInfo.length,
            itemBuilder: (context,
                    index) => /*OpenScreenAnimation(
            closedBuilder: (BuildContext _, VoidCallback openContainer) =>
                GestureDetector(
              onTap: openContainer,
              child: _ListBookItem(
                controller: _controller,
                index: index,
              ),
            ),
            openBuilder: TruyenDetailScreen(_controller.listHisInfo[index]),
          ),*/
                GestureDetector(
                  onTap: () async {
                    await _controller
                        .readDetail(_controller.listHisInfo[index].bookID!);
                  },
                  child: _ListBookItem(
                    controller: _controller,
                    index: index,
                  ),
                )),
      ),
    );
  }
}

class _ListBookItem extends StatelessWidget {
  const _ListBookItem({Key? key, required this.controller, required this.index})
      : super(key: key);
  final HistoryController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      color: Colors.grey,
      child: Column(
        children: [
          Stack(children: [
            CachedNetworkImage(
              width: double.infinity,
              height: 160,
              imageUrl: controller.listHisInfo[index].avtBook,
              fit: BoxFit.fitWidth,
            ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
            child: Text(
              controller.listHisInfo[index].name,
              style: textStyleSearch.copyWith(color: Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () async {
                      await controller.read(
                          controller.listHisInfo[index].bookID!,
                          controller.listHisInfo[index].lastNum!);
                    },
                    child: Text(
                      "Đọc tiếp",
                      style: textDetailButtonStyle.copyWith(fontSize: 12),
                    )),
                Text(
                  "${controller.listHisInfo[index].lastNum!}",
                  style: textSubStyle.copyWith(fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
