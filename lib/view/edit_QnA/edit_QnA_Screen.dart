import 'package:flash_card/Getx/controller/controller.dart';
import 'package:flash_card/utls/app_colors.dart';
import 'package:flash_card/view/home_screen/home_screen.dart';
import 'package:flash_card/view/widgets/add_new_QnA_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditQnaScreen extends StatefulWidget {
  late Controller controller;
  late String query;
  late String ans;
  int id;
  EditQnaScreen(
      {super.key,
      required this.controller,
      required this.query,
      required this.ans,
      required this.id});

  @override
  State<EditQnaScreen> createState() => _EditQnaScreenState();
}

class _EditQnaScreenState extends State<EditQnaScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.query.text = widget.query;
    widget.controller.ans.text = widget.ans;
  }

  void deleteButton() {
    widget.controller.delete(widget.id);
    Navigator.pop(context);
  }

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
          'Edit QnA',
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
                  textInput("Edit Your Question", widget.controller.query,
                      widget.controller),
                  SizedBox(
                    height: 20,
                  ),
                  textInput("Edit Your Answer", widget.controller.ans,
                      widget.controller),
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
                            deleteButton();
                            Navigator.pop(context);
                          },
                          onCancel: () {},
                        );
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
                              titleStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              onConfirm: () {
                                Navigator.pop(context);
                              });
                        } else {
                          widget.controller.editQna(widget.id);
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
