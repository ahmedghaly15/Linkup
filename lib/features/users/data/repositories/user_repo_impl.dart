import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/users/data/datasources/user_datasource.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserDataSource userDataSource;

  const UserRepoImpl({required this.userDataSource});

  @override
  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>>
      getUserData() {
    return executeAndHandleErrors<DocumentSnapshot<Map<String, dynamic>>>(
      function: () => userDataSource.getUserData(),
    );
  }

  @override
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getAllUsers() {
    return executeAndHandleErrors<QuerySnapshot<Map<String, dynamic>>>(
      function: () => userDataSource.getAllUsers(),
    );
  }
}
