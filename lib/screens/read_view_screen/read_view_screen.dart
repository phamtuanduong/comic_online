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
                      children: _c.buildReadView
                          .map(
                            (e) => _ReadContent(
                              truyenChapter: e,
                              controller: _c,
                            ),
                          )
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
                    _c,
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

class _ReadContent extends StatelessWidget {
  const _ReadContent({
    Key? key,
    required this.truyenChapter,
    required this.controller,
  }) : super(key: key);

  final TruyenChapter truyenChapter;
  final ReadViewController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(controller.title, style: textDetailButtonStyle),
        const SizedBox(height: defaultPadding / 2),
        Column(
          children: truyenChapter.listImg
              .map((e) => ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 50),
                    child: GestureDetector(
                      onTap: () {
                        controller.showMenuAction();
                      },
                      child: CachedNetworkImage(
                        imageUrl: e.path,
                        fit: BoxFit.fill,
                        placeholder: (BuildContext _, String url) =>
                            Image.asset('assets/images/action-loading.png'),
                      ),
                    ),
                  ))
              .toList(),
        ),

        //Bình luận, hiển thị vài bình luận, 3 -> 4 bình luận mới nhất cho chương này

        Text(
          "Bình luận",
          style: textDetailDsChapStyle,
        ),
        Column(
          children: const [
            Text("Bình luận 1"),
            Text("Bình luận 1"),
            Text("Bình luận 1"),
            Text("...")
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
          child: OutlinedButton(
            onPressed: () {
              controller.nextChap();
            },
            child: Text(
              "Viết bình luận",
              style: textDetailDsChapStyle,
            ),
            style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                side: const BorderSide(color: primaryColor)),
          ),
        ),
        controller.isEndChap
            ? const Text("Không có chương mới!")
            : const SizedBox(),
        const SizedBox(height: defaultPadding / 2)
      ],
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction(
    this.controller, {
    Key? key,
    required this.truyenChapter,
  }) : super(key: key);

  final TruyenChapter truyenChapter;
  final ReadViewController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.80),
      height: 45,
      child: Row(
        children: [
          ButtomBack(
            onClick: () {
              controller.back(context);
            },
            iconHeight: 25,
          ),
          Expanded(
            child: Text(
              controller.title,
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
