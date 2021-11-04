import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/comment_controllers/comment_parent_detail_page_controller.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'comment_child_detail_page_show_screen.dart';

class CommentParentDetailPageShowScreen extends StatelessWidget {
  const CommentParentDetailPageShowScreen(
    this.truyenModel, {
    Key? key,
  }) : super(key: key);
  final TruyenModel truyenModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CommentParentDetailPageController>(
          init: CommentParentDetailPageController(truyenModel),
          builder: (_) => Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  _HeaderAction(
                    _,
                    truyenModel: truyenModel,
                  ),
                  Expanded(
                    flex: 6,
                    child: _CommentParentListLoad(truyenModel: truyenModel),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentParentListLoad extends StatelessWidget {
  const _CommentParentListLoad({
    Key? key,
    required this.truyenModel,
  }) : super(key: key);

  final TruyenModel truyenModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFEEEEEE),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: _ContentTitle("Bình luận mới nhất"),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) => Card(
                        color: const Color(0xFFFFFFFF),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(children: [
                              Container(
                                margin:
                                    const EdgeInsets.all(defaultPadding / 4),
                                width: 50.0,
                                height: 50.0,
                                child:
                                    Image.asset('assets/images/guest_icon.png'),
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
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
                                        truyenModel.listCommentsParent[index]
                                                .userName +
                                            ":" +
                                            truyenModel
                                                .listCommentsParent[index]
                                                .chapName,
                                        style: textDetailDsChapStyle),
                                    Text(
                                      truyenModel
                                          .listCommentsParent[index].content,
                                      style: textStyleSearch.copyWith(
                                          color: Colors.black87),
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
                                      closedBuilder:
                                          (BuildContext _, VoidCallback open) =>
                                              TextButton(
                                        onPressed: open,
                                        child: const Icon(Icons.comment),
                                      ),
                                      openBuilder:
                                          CommentChildDetailPageShowScreen(
                                        truyenModel,
                                        truyenModel
                                            .listCommentsParent[index].id,
                                        index,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ]))),
                    childCount: truyenModel.listCommentsParent.length))
          ],
        ));
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction(
    this.controller, {
    Key? key,
    required this.truyenModel,
  }) : super(key: key);

  final TruyenModel truyenModel;
  final CommentParentDetailPageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFEEEEEE),
        child: Column(children: [
          Row(
            children: [
              ButtomBack(
                onClick: () {
                  controller.back(context);
                },
                iconHeight: 25,
              ),
              Expanded(
                child: Text(
                  'Danh sách bình luận',
                  style: textDetailCommentTitleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: defaultPadding)
            ],
          ),
        ]));
  }
}

class _ContentTitle extends StatelessWidget {
  const _ContentTitle(
    this.text, {
    Key? key,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: defaultPadding / 4, top: defaultPadding / 2),
      child:
          Text(text, style: const TextStyle(color: primaryColor, fontSize: 14)),
    );
  }
}
