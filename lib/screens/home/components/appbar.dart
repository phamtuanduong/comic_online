import 'package:comic_online/constants.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AppBar(
          centerTitle: true,
          title: GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(defaultPadding),
              child: Container(
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
            Tooltip(
              message: "Thể loại",
              child: InkWell(
                  onTap: () {},
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
