import 'package:flash_card/repository/api_models/flash_card_model/flash_card_model.dart';
import 'package:flash_card/repository/db/flash_card_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  RxList<FlashCardModel> flashCardList = <FlashCardModel>[].obs;
  FlashCardDB? database = FlashCardDB();
  TextEditingController query = TextEditingController();
  TextEditingController ans = TextEditingController();

  void fetchList() async {
    flashCardList.value = await database!.getStoredData();
  }

  void insertData() async {
    if (query.text != '') {
      await database!.insert(FlashCardModel(query: query.text, ans: ans.text));
    }
    fetchList();
  }

  void delete(int id) async {
    var data = await database!.delete(id);
    print(data);
    fetchList();
  }

  void editQna(int id) async {
    var data = await database!
        .update(FlashCardModel(id: id, query: query.text, ans: ans.text));
    print(data);
    fetchList();
  }
}
