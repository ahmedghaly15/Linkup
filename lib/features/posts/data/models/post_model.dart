import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final String? name;
  final String? uId;
  final String? postId;
  final String? image;
  final String? time;
  final String? date;
  final Timestamp? dateTime;
  final String? text;
  final String? postImage;
  final int? likes;
  final int? comments;

  const PostModel({
    this.name,
    this.uId,
    this.image,
    this.date,
    this.time,
    this.dateTime,
    this.postImage,
    this.text,
    this.comments,
    this.likes,
    this.postId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json['name'] as String?,
      uId: json['uId'] as String?,
      image: json['image'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      dateTime: json['dateTime'] as Timestamp?,
      postImage: json['postImage'] as String?,
      text: json['text'] as String?,
      comments: json['comments'] as int?,
      likes: json['likes'] as int?,
      postId: json['postId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'text': text,
      'image': image,
      'date': date,
      'time': time,
      'dateTime': dateTime,
      'postImage': postImage,
      'comments': comments,
      'likes': likes,
      'postId': postId,
    };
  }

  @override
  List<Object?> get props => [
        name,
        uId,
        text,
        image,
        date,
        time,
        dateTime,
        postImage,
        comments,
        likes,
        postId,
      ];
}
