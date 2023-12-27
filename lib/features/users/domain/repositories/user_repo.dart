import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';

abstract class UserRepo {
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getAllUsers();

  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>> getUserData();
}
