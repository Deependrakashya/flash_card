import 'package:flash_card/Getx/controller/controller.dart';
import 'package:flash_card/utls/app_colors.dart';
import 'package:flash_card/utls/constants.dart';
import 'package:flash_card/view/edit_QnA/edit_QnA_Screen.dart';
import 'package:flash_card/view/view_QnA/view_QnA_screen/view_QnA_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget flashCardItem({
  required String cardText,
  required BuildContext context,
  required Controller controller,
  required int index,
  required String cardTitle,
  required String ans,
  required String question,
}) {
  return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppColors.whiteBgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, -1),
            )
          ]),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14).copyWith(bottom: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7)),
                  color: AppColors.chatInputColor,
                  border: Border(
                      bottom: BorderSide(
                          width: 0.8, color: AppColors.teritiaryTextColor))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cardTitle,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EditQnaScreen(
                                          controller: controller,
                                          query: question,
                                          ans: ans,
                                          id: index)));
                        },
                        child: const SizedBox(
                          width: 30,
                          height: 30,
                          child: Icon(
                            color: AppColors.teritiaryTextColor,
                            size: 20,
                            Icons.edit,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'Delete',
                            middleText: 'Do you want to delete this?',
                            middleTextStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            titleStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                            onConfirm: () {
                              controller.delete(index);
                              Navigator.pop(context);
                            },
                            onCancel: () {},
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          color: AppColors.teritiaryTextColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                cardText,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ));
}
