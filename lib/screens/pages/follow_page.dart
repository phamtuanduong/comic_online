import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/components/open_screen_animation.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/follow_page_controller.dart';
import 'package:comic_online/models/models.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/style/colors.dart';
import 'package:comic_online/style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowPage extends StatelessWidget {
  const FollowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowPageController>(
      init: FollowPageController(),
      builder: (_controller) => RefreshIndicator(
        onRefresh: _controller.refeshBook,
        child: ListView.builder(
            controller: _controller.scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: _controller.listFollow.length,
            itemBuilder: (context,
                    index) => 
                GestureDetector(
                  onTap: () async {
                     await _controller
                        .readBookFollow(_controller.listFollow[index].bookID);
                  },
                  child: _ListBookItem(
                    controller: _controller,
                    index: index,
                  ),
                )),
      ),
    );
  }
}

class _ListBookItem extends StatelessWidget {
  const _ListBookItem({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);
  final FollowPageController controller;

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
                  height: 120,
                  width: 100,
                  placeholder: (context, url) {
                    return Image.asset(
                      'assets/images/backgroud-loading.png',
                      width: 100,
                      height: 120,
                    );
                  },
                  imageUrl: controller.listFollow[index].avt),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 3),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      controller.listFollow[index].namebook,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleSearch.copyWith(
                          color: const Color(0xFF1a94f4), fontSize: 18),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1, left: 3),
                          child: Text(
                             "NewChap: ${controller.listFollow[index].newChap.toString()}",
                              style: textSubStyle,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text(
                            "NewChapUpdate: ${controller.listFollow[index].newChapUpdate}",
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