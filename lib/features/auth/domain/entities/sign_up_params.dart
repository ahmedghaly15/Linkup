import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String username;
  final String email;
  final String password;
  final String phone;

  const SignUpParams({
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [username, email, password, phone];
}
