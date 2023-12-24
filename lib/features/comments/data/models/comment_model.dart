import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String? name;
  final String? uId;
  final String? image;
  final Map<String, dynamic>? commentImage;
  final String? commentText;
  final String? time;
  final String? date;
  final Timestamp? dateTime;

  const CommentModel({
    this.name,
    this.uId,
    this.image,
    this.commentImage,
    this.commentText,
    this.time,
    this.date,
    this.dateTime,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      name: json['name'] as String?,
      uId: json['uId'] as String?,
      image: json['image'] as String?,
      commentImage: json['commentImage'] as Map<String, dynamic>?,
      commentText: json['commentText'] as String?,
      time: json['time'] as String?,
      date: json['date'] as String?,
      dateTime: json['dateTime'] as Timestamp?,
    );
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

  @override
  List<Object?> get props => [
        name,
        uId,
        image,
        commentText,
        commentImage,
        time,
        date,
        dateTime,
      ];
}
