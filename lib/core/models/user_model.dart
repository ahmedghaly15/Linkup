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
  final String? xUrl;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? githubUrl;

  const UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
    this.xUrl,
    this.facebookUrl,
    this.instagramUrl,
    this.githubUrl,
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
      xUrl: json['xUrl'] as String?,
      instagramUrl: json['instagramUrl'] as String?,
      facebookUrl: json['facebookUrl'] as String?,
      githubUrl: json['githubUrl'] as String?,
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
      'githubUrl': githubUrl,
      'facebookUrl': facebookUrl,
      'instagramUrl': instagramUrl,
      'xUrl': xUrl,
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
        xUrl,
        facebookUrl,
        instagramUrl,
        githubUrl,
      ];
}
