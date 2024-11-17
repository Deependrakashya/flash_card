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

class CardState {
  late AnimationController controller;
  late Animation<double> animation;
  bool isFront = true;

  CardState(TickerProvider vsync) {
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: vsync,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  void dispose() {
    controller.dispose();
  }

  void flipCard() {
    if (isFront) {
      controller.forward();
    } else {
      controller.reverse();
    }
    isFront = !isFront;
  }
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  Controller controller = Get.put(Controller());
  List<CardState>? cardStates;

  @override
  void initState() {
    super.initState();
    controller.fetchList();
  }

  @override
  void dispose() {
    if (cardStates != null) {
      for (var state in cardStates!) {
        state.dispose();
      }
    }
    super.dispose();
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.flashCardList.isEmpty) {
          return const Center(child: Text('Please add a new Card'));
        }

        // Dynamically initialize card states if they haven't been initialized yet
        if (cardStates == null ||
            cardStates!.length != controller.flashCardList.length) {
          cardStates = List.generate(
            controller.flashCardList.length,
            (_) => CardState(this),
          );
        }

        return Container(
          margin: EdgeInsets.only(bottom: 60),
          child: ListView.builder(
            itemCount: controller.flashCardList.length,
            itemBuilder: (context, index) {
              final cardState = cardStates![index];
              final flashCard = controller.flashCardList[index];

              return Center(
                child: GestureDetector(
                  onTap: cardState.flipCard,
                  child: AnimatedBuilder(
                    animation: cardState.animation,
                    builder: (context, child) {
                      final angle = cardState.animation.value * pi;
                      final isFrontVisible = angle < pi / 2;

                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // Perspective
                          ..rotateY(angle),
                        alignment: Alignment.center,
                        child: isFrontVisible
                            ? flashCardItem(
                                title: flashCard.query.toString(),
                                context: context,
                                controller: controller,
                                index: flashCard.id!.toInt(),
                                cardTitle: 'Question',
                                ans: flashCard.ans.toString(),
                                question: flashCard.query.toString(),
                              )
                            : Transform(
                                transform: Matrix4.identity()..rotateY(pi),
                                alignment: Alignment.center,
                                child: flashCardItem(
                                  title: flashCard.ans.toString(),
                                  context: context,
                                  controller: controller,
                                  index: flashCard.id!.toInt(),
                                  cardTitle: 'Answer',
                                  ans: flashCard.ans.toString(),
                                  question: flashCard.query.toString(),
                                ),
                              ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: addQnAButton(context, controller),
    );
  }
}
