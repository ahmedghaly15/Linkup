import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/features/auth/domain/entities/sign_in_params.dart';

abstract class SignInDataSource {
  Future<UserCredential> signIn({
    required SignInParams signInParams,
  });
}
