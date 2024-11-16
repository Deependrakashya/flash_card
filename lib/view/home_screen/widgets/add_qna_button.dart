//  add new questin and answer button
import 'dart:developer';

import 'package:flash_card/Getx/controller/controller.dart';
import 'package:flash_card/utls/app_colors.dart';
import 'package:flash_card/utls/constants.dart';
import 'package:flash_card/view/add_new_QnA/pages/add_new_QnA.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget addQnAButton(BuildContext context, Controller controller) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddNewQna(
                    controller: controller,
                  )));
      log("Add New Card Button Clicked");
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppColors.whiteBgColor,
          border: Border.all(width: 0.2, color: AppColors.defaultBorderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            )
          ]),
      width: MediaQuery.of(context).size.width,
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ).copyWith(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.add,
            size: 20,
            color: AppColors.teritiaryTextColor,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            Constants.addQnaTitle,
          ),
        ],
      ),
    ),
  );
}
