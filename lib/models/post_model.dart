class PostModel {
  String? name;
  String? uId;
  String? postId;
  String? image;
  String? time;
  String? date;
  String? text;
  String? postImage;
  int? likes;
  int? comments;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.date,
    this.time,
    this.postImage,
    this.text,
    this.comments,
    this.likes,
    this.postId,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    uId = json['uId'];
    image = json['image'];
    date = json['date'];
    time = json['time'];
    postImage = json['postImage'];
    text = json['text'];
    comments = json['comments'];
    likes = json['likes'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'text': text,
      'image': image,
      'date': date,
      'time': time,
      'postImage': postImage,
      'comments': comments,
      'likes': likes,
      'postId': postId,
    };
  }
}
