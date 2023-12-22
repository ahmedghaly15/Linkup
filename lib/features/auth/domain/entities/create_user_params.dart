import 'package:equatable/equatable.dart';

class CreateUserParams extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String uId;

  const CreateUserParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
  });

  @override
  List<Object?> get props => [name, email, phone, uId];
}
