import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/features/auth/data/datasources/forgot_password/forgot_password_datasource.dart';
import 'package:social_app/service_locator.dart';

class ForgotPasswordDataSourceImpl implements ForgotPasswordDataSource {
  @override
  Future<void> forgotPassword({required String email}) async {
    return await getIt.get<FirebaseAuth>().sendPasswordResetEmail(email: email);
  }
}
