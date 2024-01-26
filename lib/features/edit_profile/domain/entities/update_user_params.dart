import 'package:equatable/equatable.dart';

class UpdateUserParams extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String bio;
  final String? xUrl;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? githubUrl;
  final String? cover;
  final String? image;

  const UpdateUserParams({
    required this.name,
    required this.phone,
    required this.bio,
    required this.email,
    this.xUrl,
    this.facebookUrl,
    this.instagramUrl,
    this.githubUrl,
    this.cover,
    this.image,
  });

  @override
  List<Object?> get props => [
        name,
        phone,
        bio,
        cover,
        image,
        email,
        xUrl,
        facebookUrl,
        instagramUrl,
        githubUrl,
      ];
}
