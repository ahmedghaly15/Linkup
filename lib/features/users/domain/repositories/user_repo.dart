import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';

abstract class UserRepo {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData();

  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts();

  Future<Either<Failure, void>> signOut();
}
