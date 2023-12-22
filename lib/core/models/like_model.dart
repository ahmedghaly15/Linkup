import 'package:equatable/equatable.dart';

class LikesModel extends Equatable {
  final String? uId;
  final String? name;
  final String? dateTime;

  const LikesModel({
    this.uId,
    this.name,
    this.dateTime,
  });

  factory LikesModel.fromJson(Map<String, dynamic> json) {
    return LikesModel(
      uId: json['uId'] as String?,
      name: json['name'] as String?,
      dateTime: json['dateTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'dateTime': dateTime,
    };
  }

  @override
  List<Object?> get props => [uId, name, dateTime];
}
