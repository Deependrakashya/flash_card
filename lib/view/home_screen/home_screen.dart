import 'dart:math';

import 'package:flash_card/Getx/controller/controller.dart';
import 'package:flash_card/utls/app_colors.dart';
import 'package:flash_card/utls/constants.dart';
import 'package:flash_card/view/home_screen/widgets/add_qna_button.dart';
import 'package:flash_card/view/home_screen/widgets/home_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;
  Controller controller = Get.put(Controller());

  @override
  void initState() {
    controller.fetchList();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightGray,
        appBar: AppBar(
          backgroundColor: AppColors.lightGray,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(
              color: AppColors.defaultBorderColor,
              height: 0.5,
            ),
          ),
          title: Text(
            Constants.appName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Obx(() {
          if (controller.flashCardList.isEmpty ||
              controller.flashCardList.length == 0) {
            return Center(child: Text('Please add a new Card'));
          }
          return ListView.builder(
              itemCount: controller.flashCardList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: flipCard,
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            // Flip the card halfway
                            final angle = _animation.value * pi;
                            final isFrontVisible = angle < pi / 2;

                            return Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001) // Perspective
                                ..rotateY(angle),
                              alignment: Alignment.center,
                              child: isFrontVisible
                                  ? flashCardItem(
                                      title: controller
                                          .flashCardList[index].query
                                          .toString(),
                                      context: context,
                                      controller: controller,
                                      index: controller.flashCardList[index].id!
                                          .toInt(),
                                      cardTitle: 'Question',
                                      ans: controller.flashCardList[index].ans
                                          .toString(),
                                      question: controller
                                          .flashCardList[index].query
                                          .toString())
                                  : Transform(
                                      transform: Matrix4.identity()
                                        ..rotateY(pi),
                                      alignment: Alignment.center,
                                      child: flashCardItem(
                                        title: controller
                                            .flashCardList[index].ans
                                            .toString(),
                                        context: context,
                                        controller: controller,
                                        index: controller
                                            .flashCardList[index].id!
                                            .toInt(),
                                        cardTitle: 'Answer',
                                        ans: controller.flashCardList[index].ans
                                            .toString(),
                                        question: controller
                                            .flashCardList[index].query
                                            .toString(),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              });
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: addQnAButton(context, controller));
  }
}
