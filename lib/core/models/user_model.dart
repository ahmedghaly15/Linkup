import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? email;
  final String? uId;
  final String? phone;
  final String? image;
  final String? cover;
  final String? bio;
  final bool? isEmailVerified;

  const UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      uId: json['uId'] as String?,
      image: json['image'] as String?,
      cover: json['cover'] as String?,
      bio: json['bio'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        uId,
        isEmailVerified,
        image,
        cover,
        bio,
      ];
}
