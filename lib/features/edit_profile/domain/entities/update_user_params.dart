import 'package:equatable/equatable.dart';

class UpdateUserParams extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String bio;
  final String? cover;
  final String? image;

  const UpdateUserParams({
    required this.name,
    required this.phone,
    required this.bio,
    required this.email,
    this.cover,
    this.image,
  });

  @override
  List<Object?> get props => [name, phone, bio, cover, image, email];
}
