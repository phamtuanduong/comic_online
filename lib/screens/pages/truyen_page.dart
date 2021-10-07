import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/truyen_page_controller.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TruyenPage extends StatelessWidget {
  const TruyenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TruyenPageController>(
        init: TruyenPageController(),
        builder: (_controller) => RefreshIndicator(
              onRefresh: _controller.refeshBook,
              child: ListView.builder(
                controller: _controller.scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: _controller.listTruyen.length,
                itemBuilder: (context, index) => OpenContainer(
                  closedElevation: 0,
                  openElevation: 0,
                  openColor: Colors.white54,
                  middleColor: Colors.transparent,
                  closedColor: bgContent,
                  transitionType: ContainerTransitionType.fadeThrough,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) =>
                      GestureDetector(
                    onTap: openContainer,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color:
                                      menuUnselectedColor.withOpacity(0.35)))),
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2,
                            vertical: defaultPadding / 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(defaultPadding / 4),
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
                                  imageUrl:
                                      _controller.listTruyen[index].avtBook),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 5, 8, 3),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      _controller.listTruyen[index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyleSearch.copyWith(
                                          color: const Color(0xFF1a94f4),
                                          fontSize: 16),
                                    ),
                                    Expanded(
                                        child: Wrap(
                                      children: _controller
                                          .listTruyen[index].categories
                                          .map((e) => CaptionTheLoai(
                                                e,
                                                onPress: () {},
                                              ))
                                          .toList(),
                                    )),
                                    const SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/icon-view.png',
                                          height: 16,
                                          width: 16,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 1, left: 3),
                                          child: Text(
                                              _controller
                                                  .listTruyen[index].totalView
                                                  .toString(),
                                              style: textSubStyle,
                                              textAlign: TextAlign.center),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Số chương: ${_controller.listTruyen[index].lastNumChap}",
                                            textAlign: TextAlign.right,
                                            style: textSubStyle.copyWith(
                                                fontSize: 12),
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
                    ),
                  ),
                  openBuilder: (BuildContext _, VoidCallback __) {
                    return TruyenDetailScreen(_controller.listTruyen[index]);
                  },
                ),
              ),
            ));
  }
}

class CaptionTheLoai extends StatelessWidget {
  const CaptionTheLoai(
    this.text, {
    Key? key,
    required this.onPress,
  }) : super(key: key);
  final String text;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 8, 2),
      child: Text(
        text,
        style: textSubStyle.copyWith(fontSize: 11),
      ),
    ));
  }
}
