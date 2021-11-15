import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/components/buttom_back.dart';
import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/read_view_controller.dart';
import 'package:comic_online/models/truyen_chapter.dart';
import 'package:comic_online/screens/comment_screens/comment_child_by_chap_show_screen.dart';
import 'package:comic_online/screens/comment_screens/comment_parent_by_chap_show_screen.dart';
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
                        httpHeaders: const <String, String>{
                          'CF-RAY': '6a619e4f0e942ee6-SIN',
                          'Content-Type': 'text/html; charset=UTF-8',
                          'user-agent':
                              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36'
                        },
                        imageUrl:
                            e.getLink(truyenChapter.bookID, truyenChapter.id),
                        fit: BoxFit.fill,
                        placeholder: (BuildContext _, String url) =>
                            Image.asset('assets/images/action-loading.png'),
                      ),
                    ),
                  ))
              .toList(),
        ),
        Text(
          "Bình luận: " + controller.title,
          style: textDetailDsChapStyle,
        ),
        // Column(
        //   children: (truyenChapter.listCommentsParent.length >= 3)
        //       ? [
        //           _CommentEndChapStyle(truyenChapter: truyenChapter, index: 0),
        //           _CommentEndChapStyle(truyenChapter: truyenChapter, index: 1),
        //           _CommentEndChapStyle(truyenChapter: truyenChapter, index: 2),
        //           const Text("...")
        //         ]
        //       : const [
        //           Text("Chưa có bình luận!"),
        //         ],
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
          child: OpenScreenAnimation(
            closedBuilder: (BuildContext _, VoidCallback open) =>
                OutlinedButton(
              onPressed: open,
              child: Text(
                "Viết bình luận",
                style: textDetailDsChapStyle,
              ),
              style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: primaryColor)),
            ),
            openBuilder: CommentParentByChapShowScreen(truyenChapter),
          ),
        ),
        controller.isLoad
            ? const CircularProgressIndicator()
            : const SizedBox(),
        controller.isEndChap
            ? const Text("Không có chương mới!")
            : const SizedBox(),
        const SizedBox(height: defaultPadding / 2)
      ],
    );
  }
}

class _CommentEndChapStyle extends StatelessWidget {
  const _CommentEndChapStyle({
    Key? key,
    required this.truyenChapter,
    required this.index,
  }) : super(key: key);

  final TruyenChapter truyenChapter;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: Container(
            padding: const EdgeInsets.all(5),
            child: Row(children: [
              Container(
                margin: const EdgeInsets.all(defaultPadding / 4),
                width: 50.0,
                height: 50.0,
                child: Image.asset('assets/images/guest_icon.png'),
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(
                    color: menuUnselectedColor,
                    width: 1.0,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        truyenChapter.listCommentsParent[index].userName +
                            ":" +
                            truyenChapter.listCommentsParent[index].chapName,
                        style: textDetailDsChapStyle),
                    Text(
                      truyenChapter.listCommentsParent[index].content,
                      style: textStyleSearch.copyWith(color: Colors.black87),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: OpenScreenAnimation(
                      closedBuilder: (BuildContext _, VoidCallback open) =>
                          TextButton(
                        onPressed: open,
                        child: const Icon(Icons.comment),
                      ),
                      openBuilder: CommentChildByChapShowScreen(
                        truyenChapter,
                        truyenChapter.listCommentsParent[index].id,
                        index,
                      ),
                    ),
                  )
                ],
              ),
            ])));
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
