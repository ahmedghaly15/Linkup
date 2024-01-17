import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/app_strings.dart';

class FirebaseFailure extends Failure {
  const FirebaseFailure({super.failureMsg});

  factory FirebaseFailure.fromFirebaseException(String code) {
    switch (code) {
      case 'user-not-found':
        return const FirebaseFailure(
            failureMsg: 'No user found for that email');

      case 'wrong-password':
        return const FirebaseFailure(failureMsg: 'Wrong Password');

      case 'weak-password':
        return const FirebaseFailure(failureMsg: 'Password is too weak');

      case 'email-already-in-use':
        return const FirebaseFailure(failureMsg: 'Account already exists');

      case 'invalid-email':
        return const FirebaseFailure(failureMsg: 'An Invalid Email');

      default:
        return const FirebaseFailure(failureMsg: AppStrings.opps);
    }
  }
}
