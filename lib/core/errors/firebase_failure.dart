import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/app_strings.dart';

class FirebaseFailure extends Failure {
  FirebaseFailure({String? failureMsg}) : super(failureMsg: failureMsg);

  factory FirebaseFailure.fromFirebaseException(FirebaseException exception) {
    String code = exception.code;

    switch (code) {
      case 'user-not-found':
        return FirebaseFailure(failureMsg: 'No user found for that email');

      case 'wrong-password':
        return FirebaseFailure(failureMsg: 'Wrong Password');

      case 'weak-password':
        return FirebaseFailure(failureMsg: 'Password is too weak');

      case 'email-already-in-use':
        return FirebaseFailure(failureMsg: 'Account already exists');

      default:
        return FirebaseFailure(failureMsg: AppStrings.opps);
    }
  }
}
