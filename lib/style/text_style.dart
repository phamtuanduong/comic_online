import 'package:comic_online/constants.dart';
import 'package:comic_online/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const textStyleSearch = TextStyle(
    color: menuUnselectedColor, fontSize: 13, fontWeight: FontWeight.normal);
final textSubStyle =
    textStyleSearch.copyWith(color: menuUnselectedColor, fontSize: 14);

final textDetailStyle =
    textStyleSearch.copyWith(color: Colors.white, fontSize: 13);

final textDetailButtonStyle = textStyleSearch.copyWith(
    color: primaryColor, fontSize: 13, fontWeight: FontWeight.normal);

final textDetailDsChapStyle = textDetailButtonStyle.copyWith(
    color: const Color(0xFF01579B),
    fontSize: 13,
    fontWeight: FontWeight.normal);
