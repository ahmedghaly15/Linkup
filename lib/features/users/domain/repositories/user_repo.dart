import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';

abstract class UserRepo {
  Future<Either<Failure, List<UserModel>>> getAllUsers();

  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>> getUserData();

  Future<Either<Failure, List<PostModel>>> getUserPosts({required String uId});

  Future<Either<Failure, void>> signOut();
}
