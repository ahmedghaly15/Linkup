import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/features/auth/data/datasources/sign_in/sign_in_datasource.dart';
import 'package:social_app/features/auth/domain/entities/sign_in_params.dart';
import 'package:social_app/service_locator.dart';

class SignInDataSourceImpl implements SignInDataSource {
  @override
  Future<UserCredential> signIn({required SignInParams signInParams}) async {
    return await getIt.get<FirebaseAuth>().signInWithEmailAndPassword(
          email: signInParams.email,
          password: signInParams.password,
        );
  }
}
