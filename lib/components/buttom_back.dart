import 'package:flutter/material.dart';

class ButtomBack extends StatelessWidget {
  const ButtomBack(
      {Key? key,
      required this.onClick,
      this.iconWidth = 32,
      this.iconHeight = 32,
      this.iconColor})
      : super(key: key);
  final Function onClick;
  final double iconWidth;
  final double iconHeight;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const StadiumBorder(),
      color: Colors.transparent,
      child: IconButton(
        onPressed: () {
          onClick();
        },
        icon: Image.asset(
          'assets/images/action-back.png',
          width: iconWidth,
          height: iconHeight,
          color: iconColor,
        ),
      ),
    );
  }
}
