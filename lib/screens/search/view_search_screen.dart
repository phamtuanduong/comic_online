import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/controllers/search_controllers/view_search_controller.dart';
import 'package:comic_online/screens/home/components/components.dart';
import 'package:comic_online/screens/screens.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewSearchScreen extends StatelessWidget {
  const ViewSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewSearchController>(
      init: ViewSearchController(),
      builder: (_controller) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: CustomAppBar(
              isBackAction: true,
              textEditingController: _controller.textEditingController,
              actionClick: () {},
              action: Tooltip(
                message: "Tìm kiếm",
                child: InkWell(
                    onTap: () {
                      _controller.search();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      child: Image.asset(
                        'assets/images/icon-search.png',
                        color: Colors.black87,
                        height: 32,
                        width: 32,
                      ),
                    )),
              )),
        ),
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding / 2, horizontal: defaultPadding / 4),
              width: double.infinity,
              color: bgContent,
              child: CustomScrollView(
                controller: _controller.scrollController,
                slivers: [
                  SliverAppBar(
                    leading: const SizedBox(),
                    leadingWidth: 0,
                    snap: true,
                    floating: true,
                    expandedHeight: _controller.getSize(),
                    flexibleSpace: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 160),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          const Text(
                            "Lịch sử tìm kiếm",
                            style: textStyleSearch,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 35,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                        childAspectRatio: 3 / 4),
                                itemBuilder: (context, i) => InkWell(
                                  onTap: () {
                                    _controller.changeSearch(i);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    color: menuUnselectedColor.withOpacity(.24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _controller.listHisSearch[i],
                                          style: textSubStyle,
                                        ),
                                        TextButton(
                                            onPressed: () {},
                                            child: const Icon(Icons.clear,
                                                color: menuUnselectedColor),
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero))
                                      ],
                                    ),
                                  ),
                                ),
                                itemCount: _controller.listHisSearch.length,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (content, i) => OpenScreenAnimation(
                                closedBuilder: (BuildContext _,
                                        VoidCallback openContainer) =>
                                    GestureDetector(
                                  onTap: openContainer,
                                  child: _ListBookItem(
                                    controller: _controller,
                                    index: i,
                                  ),
                                ),
                                openBuilder: TruyenDetailScreen(
                                    _controller.listTruyen[i]),
                              ),
                          childCount: _controller.listTruyen.length))
                ],
              )),
        ),
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
  final ViewSearchController controller;
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
                  height: 130,
                  width: 100,
                  placeholder: (context, url) {
                    return Image.asset(
                      'assets/images/backgroud-loading.png',
                      width: 100,
                      height: 130,
                    );
                  },
                  imageUrl: controller.listTruyen[index].avtBook),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 3),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      controller.listTruyen[index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleSearch.copyWith(
                          color: const Color(0xFF1a94f4), fontSize: 16),
                    ),
                    Expanded(
                        child: Wrap(
                      children: controller.listTruyen[index].categories
                          .map((e) => CaptionTheLoai(
                                e,
                                onPress: () {},
                              ))
                          .toList(),
                    )),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon-view.png',
                          height: 16,
                          width: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1, left: 3),
                          child: Text(
                              controller.listTruyen[index].totalView.toString(),
                              style: textSubStyle,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text(
                            "Số chương: ${controller.listTruyen[index].lastNumChap}",
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

class CaptionTheLoai extends StatelessWidget {
  const CaptionTheLoai(
    this.text, {
    Key? key,
    required this.onPress,
  }) : super(key: key);
  final String text;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 8, 2),
      child: Text(
        text,
        style: textSubStyle.copyWith(fontSize: 11),
      ),
    ));
  }
}
