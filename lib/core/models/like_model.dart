class LikesModel {
  String? uId;
  String? name;
  String? dateTime;

  LikesModel({
    this.uId,
    this.name,
    this.dateTime,
  });

  LikesModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'dateTime': dateTime,
    };
  }
}
