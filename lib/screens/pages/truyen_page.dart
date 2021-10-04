import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/controllers/truyen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TruyenPage extends StatelessWidget {
  const TruyenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TruyenController>(
        init: TruyenController(),
        builder: (_controller) => ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _controller.listTruyen.length,
              itemBuilder: (context, index) => Container(
                height: 120,
                child: Row(
                  children: [
                    CachedNetworkImage(
                        imageUrl: _controller.listTruyen[index].avtBook),
                    Expanded(
                      child: Text(
                        _controller.listTruyen[index].name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
