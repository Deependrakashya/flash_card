class FlashCardModel {
  int? id;
  String? query;
  String? ans;

  FlashCardModel({this.id, this.query, this.ans});

  FlashCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    query = json['query'];
    ans = json['ans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['query'] = this.query;
    data['ans'] = this.ans;
    return data;
  }
}
