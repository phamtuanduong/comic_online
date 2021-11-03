import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/truyen_controllers/comment_controller.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentDetailParentViewScreen extends StatelessWidget {
  const CommentDetailParentViewScreen(
    this.truyenModel,
    this.parentID,
    this.index, {
    Key? key,
  }) : super(key: key);
  final TruyenModel truyenModel;
  final int parentID;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CommentController>(
          init: CommentController(truyenModel, parentID),
          builder: (_) => Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  _HeaderAction(
                    _,
                    truyenModel: truyenModel,
                    index: index,
                  ),
                  Expanded(
                    flex: 6,
                    child: _CommentDetailLoadChild(truyenModel: truyenModel),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          color: Colors.white,
                          child: _FooterAction(_, _.textCommentController)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentDetailLoadChild extends StatelessWidget {
  const _CommentDetailLoadChild({
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
                child: _ContentTitle("Trả lời mới nhất"),
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
                                        truyenModel.listCommentsChild[index]
                                                .userName +
                                            ":" +
                                            truyenModel.listCommentsChild[index]
                                                .chapName,
                                        style: textDetailDsChapStyle),
                                    Text(
                                      truyenModel
                                          .listCommentsChild[index].content,
                                      style: textStyleSearch.copyWith(
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ]))),
                    childCount: truyenModel.listCommentsChild.length))
          ],
        ));
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction(
    this.controller, {
    Key? key,
    required this.truyenModel,
    required this.index,
  }) : super(key: key);

  final TruyenModel truyenModel;
  final CommentController controller;
  final int index;
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
                  'Chi tiết bình luận',
                  style: textDetailCommentTitleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: defaultPadding)
            ],
          ),
          Card(
              margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
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
                              truyenModel.listCommentsParent[index].userName +
                                  ":" +
                                  truyenModel
                                      .listCommentsParent[index].chapName,
                              style: textDetailDsChapStyle),
                          Text(
                            truyenModel.listCommentsParent[index].content,
                            style:
                                textStyleSearch.copyWith(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ]))),
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

class _FooterAction extends StatelessWidget {
  const _FooterAction(
    this.controller,
    this.textCommentController, {
    Key? key,
  }) : super(key: key);
  final CommentController controller;
  final TextEditingController textCommentController;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 350,
          child: TextField(
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Nhập bình luận',
                prefixIcon: const Icon(Icons.comment),
                suffixIcon: IconButton(
                    onPressed: () {
                      // ignore: avoid_print
                      print(textCommentController.text);
                    },
                    icon: const Icon(Icons.check))),
            controller: textCommentController,
          ),
        ),
      ],
    );
    /*Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'enter'),
            ),
          ],
        ),
      ),
    );*/
  }
}
