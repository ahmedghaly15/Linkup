import 'package:equatable/equatable.dart';

class LikeModel extends Equatable {
  final String? uId;
  final String? name;
  final String? profileImage;
  final String? email;
  final String? dateTime;

  const LikeModel({
    this.uId,
    this.name,
    this.email,
    this.profileImage,
    this.dateTime,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      uId: json['uId'] as String?,
      name: json['name'] as String?,
      dateTime: json['dateTime'] as String?,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'dateTime': dateTime,
      'email': email,
      'profileImage': profileImage,
    };
  }

  @override
  List<Object?> get props => [uId, name, dateTime, profileImage, email];
}
