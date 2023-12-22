import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/features/auth/domain/entities/create_user_params.dart';
import 'package:social_app/features/auth/domain/entities/sign_up_params.dart';

abstract class SignUpDataSource {
  Future<UserCredential> signUp({
    required SignUpParams signUpParams,
  });

  Future<void> firestoreCreateUSer({
    required CreateUserParams createUserParams,
  });
}
