import 'package:animations/animations.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';

typedef CloseContainerBuilder = Widget Function(
  BuildContext context,
  VoidCallback action,
);

class OpenScreenAnimation extends StatelessWidget {
  const OpenScreenAnimation({
    Key? key,
    required this.closedBuilder,
    required this.openBuilder,
  }) : super(key: key);
  final CloseContainerBuilder closedBuilder;
  final Widget openBuilder;
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      openElevation: 0,
      openColor: Colors.white54,
      middleColor: Colors.transparent,
      closedColor: bgContent,
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: closedBuilder,
      openBuilder: (BuildContext _, VoidCallback __) => openBuilder,
    );
  }
}
