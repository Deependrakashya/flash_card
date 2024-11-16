import 'package:flash_card/utls/app_colors.dart';
import 'package:flutter/material.dart';

Widget textInput(String lableText, TextEditingController controller) {
  final borderRadius = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.teritiaryTextColor, width: 0.5));
  return TextField(
    textInputAction: TextInputAction.newline,
    keyboardType: TextInputType.multiline,
    maxLines: null,
    controller: controller,
    decoration: InputDecoration(
        labelText: lableText,
        labelStyle: TextStyle(color: Colors.black),
        border: borderRadius,
        focusedBorder: borderRadius),
  );
}
