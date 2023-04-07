class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.postImage,
    this.text,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'text': text,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
    };
  }
}
