import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/view_with_cate_screen.dart';
import 'package:comic_online/screens/pages/truyen_page.dart';
import 'package:comic_online/screens/truyen_detail_screen/truyen_detail_screen.dart';
import 'package:comic_online/style/colors.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewWithCateScreen extends StatelessWidget {
  const ViewWithCateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtomBack(
          iconHeight: 30,
          iconWidth: 30,
          onClick: () {
            Get.back();
          },
        ),
        title: Text(
          "Kênh",
          style: textSubStyle.copyWith(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<ViewWithCateController>(
            init: ViewWithCateController(),
            builder: (_controller) => Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: _ButtonCate(
                                  i,
                                  _controller,
                                  name: _controller.listCate[i].name,
                                  onClick: () async {
                                    await _controller.changeIndex(i);
                                  },
                                ),
                              ),
                          itemCount: _controller.listCate.length),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Expanded(
                        child: _controller.listTruyen.isNotEmpty
                            ? ListView.builder(
                                controller: _controller.scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, i) =>
                                    OpenScreenAnimation(
                                  closedBuilder: (BuildContext _,
                                          VoidCallback openContainer) =>
                                      GestureDetector(
                                    onTap: openContainer,
                                    child: _ListBookItem(
                                      controller: _controller,
                                      index: i,
                                    ),
                                  ),
                                  openBuilder: TruyenDetailScreen(
                                      _controller.listTruyen[i]),
                                ),
                                itemCount: _controller.listTruyen.length,
                              )
                            : const Center(
                                child: Text("Không có truyện!"),
                              ))
                  ],
                )),
      ),
    );
  }
}

class _ButtonCate extends StatelessWidget {
  const _ButtonCate(
    this.index,
    this.controller, {
    Key? key,
    required this.onClick,
    required this.name,
  }) : super(key: key);
  final int index;
  final String name;
  final ViewWithCateController controller;
  final Function onClick;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await onClick();
      },
      child: Text(
        name,
        style: controller.isSelected(index)
            ? textDetailButtonStyle
            : textDetailButtonStyle.copyWith(color: menuUnselectedColor),
      ),
      style: TextButton.styleFrom(
          backgroundColor: controller.isSelected(index)
              ? primaryColor.withOpacity(0.14)
              : primaryColor.withOpacity(0.05)),
    );
  }
}

class _ListBookItem extends StatelessWidget {
  const _ListBookItem({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);
  final ViewWithCateController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: menuUnselectedColor.withOpacity(0.35)))),
      height: 140,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding / 2, vertical: defaultPadding / 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(defaultPadding / 4),
              child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  height: 130,
                  width: 100,
                  placeholder: (context, url) {
                    return Image.asset(
                      'assets/images/backgroud-loading.png',
                      width: 100,
                      height: 130,
                    );
                  },
                  imageUrl: controller.listTruyen[index].avtBook),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 3),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      controller.listTruyen[index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleSearch.copyWith(
                          color: const Color(0xFF1a94f4), fontSize: 16),
                    ),
                    Expanded(
                        child: Wrap(
                      children: controller.listTruyen[index].categories
                          .map((e) => CaptionTheLoai(
                                e,
                                onPress: () {},
                              ))
                          .toList(),
                    )),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon-view.png',
                          height: 16,
                          width: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1, left: 3),
                          child: Text(
                              controller.listTruyen[index].totalView.toString(),
                              style: textSubStyle,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text(
                            "Số chương: ${controller.listTruyen[index].lastNumChap}",
                            textAlign: TextAlign.right,
                            style: textSubStyle.copyWith(fontSize: 12),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
