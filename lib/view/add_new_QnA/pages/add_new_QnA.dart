import 'package:flash_card/Getx/controller/controller.dart';
import 'package:flash_card/utls/app_colors.dart';
import 'package:flash_card/view/widgets/add_new_QnA_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewQna extends StatefulWidget {
  Controller controller;
  AddNewQna({super.key, required this.controller});

  @override
  State<AddNewQna> createState() => _AddNewQnaState();
}

class _AddNewQnaState extends State<AddNewQna> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.query.text = '';
    widget.controller.ans.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'New Question',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height * .9,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  textInput("What's Your Question", widget.controller.query),
                  SizedBox(
                    height: 20,
                  ),
                  textInput("Type Your Answer", widget.controller.ans),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget.controller.query.text = '';
                        widget.controller.ans.text = '';
                      },
                      child: Icon(
                        Icons.delete,
                        color: AppColors.teritiaryTextColor,
                      )),
                  ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        if (widget.controller.query.text.isEmpty) {
                          Get.defaultDialog(
                              title: 'Error',
                              middleText: 'Question can not be empty !',
                              onConfirm: () {
                                Navigator.pop(context);
                              },
                              titleStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600));
                        } else {
                          widget.controller.insertData();
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(
                        Icons.save,
                        color: AppColors.teritiaryTextColor,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
