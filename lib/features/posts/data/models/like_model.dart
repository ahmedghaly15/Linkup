import 'package:equatable/equatable.dart';
import 'package:social_app/core/models/user_model.dart';

class LikeModel extends Equatable {
  final UserModel? user;
  final String? dateTime;

  const LikeModel({
    this.user,
    this.dateTime,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      dateTime: json['dateTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'dateTime': dateTime,
    };
  }

  @override
  List<Object?> get props => [user, dateTime];
}
