import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/components/buttom_back.dart';
import 'package:comic_online/components/open_screen_animation.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/truyen_controllers/truyen_detail_controller.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/screens/read_view_screen/comment_view_screen.dart';
import 'package:comic_online/screens/read_view_screen/read_view_screen.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/bottomsheet_list_chapter.dart';

class TruyenDetailScreen extends StatelessWidget {
  const TruyenDetailScreen(this.truyenModel, {Key? key}) : super(key: key);
  final TruyenModel truyenModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TruyenDetailController>(
      init: TruyenDetailController(truyenModel),
      builder: (_controller) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _Header(truyenModel: truyenModel),
              Expanded(
                  flex: 6,
                  child: Container(
                      color: const Color(0xFFEEEEEE),
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          _ContentSliverAppBar(_controller,
                              truyenModel: truyenModel),
                          _ContentInfomation(_controller,
                              truyenModel: truyenModel),
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding / 2),
                              child: _ContentTitle("Bình luận mới nhất"),
                            ),
                          ),
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (_, index) => _CommentLoadDetails(
                                        controller: _controller,
                                        truyenModel: truyenModel,
                                        index: index,
                                        onPress: () {},
                                      ),
                                  childCount:
                                      truyenModel.listCommentsParent.length))
                        ],
                      ))),
              Expanded(
                  flex: 1,
                  child: Container(
                      color: Colors.white, child: _Footer(_controller)))
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentLoadDetails extends StatelessWidget {
  const _CommentLoadDetails({
    Key? key,
    required this.controller,
    required this.truyenModel,
    required this.index,
    required this.onPress,
  }) : super(key: key);

  final TruyenDetailController controller;
  final TruyenModel truyenModel;
  final int index;
  final Function onPress;

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
                        truyenModel.listCommentsParent[index].userName +
                            ":" +
                            truyenModel.listCommentsParent[index].chapName,
                        style: textDetailDsChapStyle),
                    Text(
                      truyenModel.listCommentsParent[index].content,
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
                      openBuilder: CommentDetailParentViewScreen(
                        truyenModel,
                        truyenModel.listCommentsParent[index].id,
                        index,
                      ),
                    ),
                  )
                ],
              )
            ])));
  }
}

class _Footer extends StatelessWidget {
  const _Footer(
    this.controller, {
    Key? key,
  }) : super(key: key);
  final TruyenDetailController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            controller.readChapFirst();
          },
          child: Text("Bắt đầu đọc",
              style: textDetailButtonStyle.copyWith(color: Colors.white)),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF1565C0),
          ),
        ),
        controller.isReaded
            ? TextButton(
                onPressed: () {
                  controller.docTiep();
                },
                child: Text("Đọc tiếp C.${controller.getNameLastChap()}",
                    style: textDetailButtonStyle.copyWith(color: Colors.white)),
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFF1744)))
            : const SizedBox(),
        TextButton(
            onPressed: () {},
            child: Text("Bình luận",
                style: textDetailButtonStyle.copyWith(color: Colors.white)),
            style:
                TextButton.styleFrom(backgroundColor: const Color(0xFF1A94FF))),
        TextButton(
            onPressed: () async {
              await controller.showListChapter(
                  context,
                  BottomSheetListChapter(
                      listChapter: controller.getListChap()));
            },
            child: Text("D.S Chương",
                style: textDetailButtonStyle.copyWith(color: Colors.white)),
            style:
                TextButton.styleFrom(backgroundColor: const Color(0xFF00796B))),
      ],
    );
  }
}

class _ContentInfomation extends StatelessWidget {
  const _ContentInfomation(
    this.controller, {
    Key? key,
    required this.truyenModel,
  }) : super(key: key);

  final TruyenModel truyenModel;
  final TruyenDetailController controller;

  @override
  Widget build(BuildContext context) {
    // controller.isDesMaxLine = ;
    final double maxLine =
        (truyenModel.description.length * 11.5) / Get.mediaQuery.size.width;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ContentTitle("Mô tả truyện"),
            Container(
              padding: const EdgeInsets.all(5),
              child: Text(
                truyenModel.description,
                style: textStyleSearch.copyWith(color: Colors.black87),
                maxLines: controller.maxLine,
                overflow: TextOverflow.fade,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: menuUnselectedColor.withOpacity(0.5)),
              ),
            ),
            maxLine > 6
                ? Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          controller.viewDesMore(
                              int.parse(maxLine.toString().split(".").first));
                        },
                        child: Text(
                          controller.maxLine > 6 ? "Ẩn" : "Xem thêm",
                          style: textDetailButtonStyle,
                        )))
                : const SizedBox(),
            const _ContentTitle("Chương mới nhất"),
            truyenModel.listChapters.isNotEmpty
                ? Column(
                    children: [
                      _ContentChapBanner(
                          truyenModel: truyenModel, index: 0, onPress: () {}),
                      _ContentChapBanner(
                          truyenModel: truyenModel, index: 1, onPress: () {}),
                      _ContentChapBanner(
                          truyenModel: truyenModel, index: 2, onPress: () {}),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _ContentChapBanner extends StatelessWidget {
  const _ContentChapBanner({
    Key? key,
    required this.truyenModel,
    required this.index,
    required this.onPress,
  }) : super(key: key);
  final TruyenModel truyenModel;
  final int index;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return truyenModel.listChapters.length >= index
        ? SizedBox(
            width: double.infinity,
            child: OpenScreenAnimation(
              closedBuilder: (BuildContext _, VoidCallback open) => TextButton(
                onPressed: open,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(truyenModel.listChapters[index].getNameUpcase(),
                        style: textDetailDsChapStyle),
                    Text(truyenModel.listChapters[index].getUpDateFormat(),
                        style: textStyleSearch.copyWith(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                ),
                style: TextButton.styleFrom(alignment: Alignment.centerLeft),
              ),
              openBuilder: ReadViewScreen(truyenModel.listChapters[index]),
            ),
          )
        : const SizedBox();
  }
}

class _ContentSliverAppBar extends StatelessWidget {
  const _ContentSliverAppBar(
    this.controller, {
    Key? key,
    required this.truyenModel,
  }) : super(key: key);

  final TruyenModel truyenModel;
  final TruyenDetailController controller;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leadingWidth: double.maxFinite,
      leading: Padding(
        padding: const EdgeInsets.only(left: defaultPadding / 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: controller.getRateStar(),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text("${truyenModel.rateCount} đánh giá",
                  style: textSubStyle, textAlign: TextAlign.center),
            )
          ],
        ),
      ),
      actions: [
        SizedBox(
          child: Tooltip(
            message: "Yêu thích",
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                (0 == 1)
                    ? 'assets/images/icon_post_detail_like_selected.png'
                    : 'assets/images/icon_post_detail_like_default.png',
                height: 28,
                width: 28,
                //điều kiên (?? == 1) hoặc (?? == true)
                //Chỗ này BÁCH sẽ xử lý, if là yêu thich color = null ngược lại color = menuUnselect ,
                //hay tùy chọn color nào cũng đc (FolleBook Loading)
                color: (0 == 1) ? null : menuUnselectedColor1,
              ),
            ),
          ),
        ),
        const SizedBox(width: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultPadding / 2, horizontal: defaultPadding / 4),
          child: OutlinedButton(
            onPressed: () async {
              await controller.followBook();
            },
            child: Row(
              children: [
                !controller.isFollow
                    ? const Icon(Icons.bookmark_add_rounded)
                    : const Icon(Icons.bookmark_rounded),
                const SizedBox(width: defaultPadding / 8),
                Text(
                  !controller.isFollow ? "Theo dõi" : "Đã theo dõi",
                  style: textDetailButtonStyle,
                )
              ],
            ),
            style: OutlinedButton.styleFrom(
                backgroundColor:
                    controller.isFollow ? primaryColor.withOpacity(0.15) : null,
                padding: const EdgeInsets.symmetric(horizontal: 10)),
          ),
        )
      ],
    );
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

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.truyenModel,
  }) : super(key: key);

  final TruyenModel truyenModel;

  @override
  Widget build(BuildContext context) {
    Size _size = Get.mediaQuery.size;
    const double _sizeIcon = 25;
    return Expanded(
        flex: 4,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/book-background.png',
              fit: BoxFit.fill,
            ),
            Container(
              color: Colors.black54,
            ),
            Positioned(
                top: 5,
                left: 5,
                child: ButtomBack(
                  onClick: () {
                    Navigator.pop(context);
                  },
                )),
            Positioned(
                bottom: 10,
                left: 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(defaultPadding / 2),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: truyenModel.avtBook,
                        width: 130,
                        height: _size.height / 4 + 15,
                      ),
                    ),
                    const SizedBox(width: defaultPadding / 2),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: _size.width / 1.46 - 30,
                          maxHeight: _size.height / 3.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tên truyện: ${truyenModel.name}",
                            style: textDetailStyle,
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          Text(
                            "Thể loại: ${truyenModel.getCatagory()}",
                            style: textDetailStyle,
                            maxLines: 2,
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          Text(
                            "Tác giả: ${truyenModel.getAuthor()}",
                            style: textDetailStyle,
                            maxLines: 2,
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          Text(
                            "Tình trạng: ${truyenModel.status}",
                            style: textDetailStyle,
                            maxLines: 2,
                          ),
                          const SizedBox(height: defaultPadding),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/icon_post_edit_keyboard_video.png',
                                    height: _sizeIcon,
                                  ),
                                  Text(
                                    truyenModel.totalView.toString(),
                                    style: textSubStyle,
                                  ),
                                  const SizedBox(width: defaultPadding),
                                  Image.asset(
                                    'assets/images/icon_post_detail_like_default.png',
                                    height: _sizeIcon,
                                    color: iconDetail,
                                  ),
                                  Text(
                                    truyenModel.likeCount.toString(),
                                    style: textSubStyle,
                                  ),
                                  const SizedBox(width: defaultPadding),
                                  Image.asset(
                                    'assets/images/icon_collection_btn_normal.png',
                                    height: _sizeIcon,
                                    color: iconDetail,
                                  ),
                                  Text(
                                    truyenModel.follow.toString(),
                                    style: textSubStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding / 4),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
