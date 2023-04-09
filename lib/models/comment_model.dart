class CommentModel {
  String? name;
  String? uId;
  String? image;
  Map<String, dynamic>? commentImage;
  String? commentText;
  String? time;
  String? date;

  CommentModel({
    this.name,
    this.uId,
    this.image,
    this.commentImage,
    this.commentText,
    this.time,
    this.date,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    commentImage = json['commentImage'];
    commentText = json['commentText'];
    time = json['time'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'commentImage': commentImage,
      'commentText': commentText,
      'time': time,
      'date': date,
    };
  }
}
