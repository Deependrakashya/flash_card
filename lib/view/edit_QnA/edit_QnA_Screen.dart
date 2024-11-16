import 'package:flash_card/Getx/controller/controller.dart';
import 'package:flash_card/utls/app_colors.dart';
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
                  textInput("Edit Your Question", widget.controller.query),
                  SizedBox(
                    height: 20,
                  ),
                  textInput("Edit Your Answer", widget.controller.ans),
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
                        widget.controller.delete(widget.id);
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.delete,
                        color: AppColors.teritiaryTextColor,
                      )),
                  ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        widget.controller.insertData();
                        Navigator.pop(context);
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
