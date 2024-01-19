import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/core/models/user_model.dart';

class PostModel extends Equatable {
  final UserModel? user;
  final String? postId;
  final String? time;
  final String? date;
  final Timestamp? dateTime;
  final String? text;
  final String? postImage;
  final int? likes;
  final int? comments;

  const PostModel({
    this.user,
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
      user: UserModel.fromJson(json['user'] ?? {}),
      text: json['text'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      dateTime: json['dateTime'] as Timestamp?,
      postImage: json['postImage'] as String?,
      comments: json['comments'] as int?,
      likes: json['likes'] as int?,
      postId: json['postId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'text': text,
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
        user,
        text,
        date,
        time,
        dateTime,
        postImage,
        comments,
        likes,
        postId,
      ];
}
