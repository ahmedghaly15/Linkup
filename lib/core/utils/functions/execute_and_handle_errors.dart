import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/errors/firebase_failure.dart';
import 'package:social_app/core/internet/internet_checker.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/service_locator.dart';

Future<Either<Failure, T>> executeAndHandleErrors<T>({
  required Future<T> Function() function,
}) async {
  if (await getIt.get<InternetChecker>().isConnected) {
    try {
      final result = await function();

      return Right(result);
    } catch (failure) {
      if (failure is FirebaseException) {
        return Left(FirebaseFailure.fromFirebaseException(failure.code));
      }
      return Left(FirebaseFailure(failureMsg: failure.toString()));
    }
  } else {
    return const Left(FirebaseFailure(failureMsg: AppStrings.noInternet));
  }
}
