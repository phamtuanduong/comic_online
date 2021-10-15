import 'package:comic_online/style/style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText,
    this.onChanged,
    this.isPassword = false,
    this.controller,
    this.suffixIcon,
    this.invalidText,
  }) : super(key: key);
  final String? hintText;
  final Function(String)? onChanged;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? invalidText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      onChanged: onChanged,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textSubStyle,
        errorText: invalidText,
        errorStyle: textSubStyle.copyWith(color: Colors.red, fontSize: 12),
        suffixIcon: suffixIcon,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: menuUnselectedColor, width: 2)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: menuUnselectedColor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2)),
      ),
    );
  }
}
