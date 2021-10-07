import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/truyen_detail_controller.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                    child: Column(
                      children: [
                        _Content_TopBar(_controller, truyenModel: truyenModel),
                        Expanded(
                            child: CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Text("Mô tả truyện"),
                                  Text(truyenModel.description)
                                ],
                              ),
                            ),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, i) =>
                                        Text(truyenModel.listChapters[i].name),
                                    childCount:
                                        truyenModel.listChapters.length)),
                          ],
                        ))
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class _Content_TopBar extends StatelessWidget {
  const _Content_TopBar(
    this.controller, {
    Key? key,
    required this.truyenModel,
  }) : super(key: key);

  final TruyenModel truyenModel;
  final TruyenDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: defaultPadding / 2),
          Expanded(
            flex: 1,
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
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Tooltip(
                    message: "Yêu thích",
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset(
                        (0 == 1)
                            ? 'assets/images/icon_post_detail_like_selected.png'
                            : 'assets/images/icon_post_detail_like_default.png',
                        height: 32,
                        //điều kiên (?? == 1) hoặc (?? == true)
                        //Chỗ này BÁCH sẽ xử lý, if là yêu thich color = null ngược lại color = menuUnselect ,
                        //hay tùy chọn color nào cũng đc (FolleBook Loading)
                        color: (0 == 1) ? null : menuUnselectedColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Icon(Icons.bookmark_add_rounded),
                        const SizedBox(width: defaultPadding / 8),
                        Text(
                          "Theo dõi",
                          style: textDetailButtonStyle,
                        )
                      ],
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10)),
                  )
                ],
              )),
          const SizedBox(width: defaultPadding / 2),
        ],
      ),
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
                child: Material(
                  shape: const StadiumBorder(),
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/images/action-back.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
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
