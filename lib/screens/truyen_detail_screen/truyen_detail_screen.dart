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
                        Container(
                          color: Colors.white,
                          height: 50,
                          child: Row(
                            children: [
                              Row(
                                children: _controller.getRateStar(),
                              )
                            ],
                          ),
                        )
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
                      constraints:
                          BoxConstraints(maxWidth: _size.width / 1.46 - 30),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
