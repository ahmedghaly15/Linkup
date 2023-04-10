import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? name;
  String? uId;
  String? image;
  Map<String, dynamic>? commentImage;
  String? commentText;
  String? time;
  String? date;
  Timestamp? dateTime;

  CommentModel({
    this.name,
    this.uId,
    this.image,
    this.commentImage,
    this.commentText,
    this.time,
    this.date,
    this.dateTime,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    commentImage = json['commentImage'];
    commentText = json['commentText'];
    time = json['time'];
    date = json['date'];
    dateTime = json['dateTime'];
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
      'dateTime': dateTime,
    };
  }
}
