import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/components/buttom_back.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/read_view_controller.dart';
import 'package:comic_online/models/truyen_chapter.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadViewScreen extends StatelessWidget {
  const ReadViewScreen(
    this.truyenChapter, {
    Key? key,
  }) : super(key: key);
  final TruyenChapter truyenChapter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ReadViewController>(
          init: ReadViewController(truyenChapter),
          builder: (_c) => Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    controller: _c.scrollController,
                    child: Column(
                      children: truyenChapter.listImg
                          .map((e) => ConstrainedBox(
                                constraints:
                                    const BoxConstraints(minHeight: 50),
                                child: GestureDetector(
                                  onTap: () {
                                    _c.showMenuAction();
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: e.path,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizeTransition(
                  axisAlignment: 1.0,
                  sizeFactor: _c.menuAnimation,
                  child: _HeaderAction(
                    truyenChapter: truyenChapter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({
    Key? key,
    required this.truyenChapter,
  }) : super(key: key);

  final TruyenChapter truyenChapter;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.80),
      height: 45,
      child: Row(
        children: [
          ButtomBack(
            onClick: () {
              Navigator.pop(context);
            },
            iconHeight: 25,
          ),
          Expanded(
            child: Text(
              truyenChapter.getNameUpcase(),
              style: textSubStyle.copyWith(color: Colors.white),
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "Tất cả chương",
                style: textDetailButtonStyle.copyWith(color: Colors.white),
              )),
          const SizedBox(width: defaultPadding / 4)
        ],
      ),
    );
  }
}
