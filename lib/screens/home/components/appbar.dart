import 'package:comic_online/components/componets.dart';
import 'package:comic_online/constants.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.searchClick,
    required this.actionClick,
    this.isBackAction = false,
    this.onChanged,
    this.action,
    this.textEditingController,
  }) : super(key: key);
  final Function? searchClick;
  final Function actionClick;
  final bool isBackAction;
  final Widget? action;
  final TextEditingController? textEditingController;

  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AppBar(
          leading: isBackAction
              ? ButtomBack(
                  onClick: () {
                    Get.back();
                  },
                )
              : const Text(""),
          leadingWidth: isBackAction ? null : 0,
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              searchClick!();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(defaultPadding),
              child: isBackAction
                  ? Container(
                      height: 32,
                      color: Colors.grey.withOpacity(0.17),
                      child: TextField(
                          controller: textEditingController,
                          autofocus: true,
                          onChanged: onChanged,
                          decoration: InputDecoration(
                              hintText: "Tác phẩm/Tác giả",
                              hintStyle: textStyleSearch,
                              errorStyle: textSubStyle.copyWith(
                                  color: Colors.red, fontSize: 12),
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              filled: false,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              isDense: true)),
                    )
                  : Container(
                      color: Colors.grey.withOpacity(0.17),
                      child: Row(
                        children: [
                          const SizedBox(width: defaultPadding / 8),
                          Image.asset(
                            'assets/images/icon-search.png',
                            height: 32,
                            width: 32,
                          ),
                          const SizedBox(width: defaultPadding / 4),
                          const Text("Tác giả/Tác phẩm", style: textStyleSearch)
                        ],
                      ),
                    ),
            ),
          ),
          actions: [
            action ??
                Tooltip(
                  message: "Thể loại",
                  child: InkWell(
                      onTap: () {
                        actionClick();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        child: Image.asset(
                          'assets/images/action-theloai.png',
                          color: Colors.black87,
                          height: 32,
                          width: 32,
                        ),
                      )),
                )
          ],
        ),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 1), blurRadius: 5)
            ],
            border: Border(
                bottom:
                    BorderSide(color: menuUnselectedColor.withOpacity(0.01)))));
  }
}
