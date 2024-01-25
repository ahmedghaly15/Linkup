import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/core/models/user_model.dart';

class CommentModel extends Equatable {
  final UserModel? user;
  final Map<String, dynamic>? commentImage;
  final String? commentText;
  final String? time;
  final String? date;
  final Timestamp? dateTime;

  const CommentModel({
    this.user,
    this.commentImage,
    this.commentText,
    this.time,
    this.date,
    this.dateTime,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      commentImage: json['commentImage'] as Map<String, dynamic>?,
      commentText: json['commentText'] as String?,
      time: json['time'] as String?,
      date: json['date'] as String?,
      dateTime: json['dateTime'] as Timestamp?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'commentImage': commentImage,
      'commentText': commentText,
      'time': time,
      'date': date,
      'dateTime': dateTime,
    };
  }

  @override
  List<Object?> get props => [
        user,
        commentText,
        commentImage,
        time,
        date,
        dateTime,
      ];
}
