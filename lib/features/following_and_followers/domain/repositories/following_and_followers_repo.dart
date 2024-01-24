import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';

abstract class FollowingAndFollowersRepo {
  Future<Either<Failure, List<UserModel>>> getFollowers();

  Future<Either<Failure, List<UserModel>>> getFollowing();

  Future<Either<Failure, void>> follow({required UserModel user});

  Future<Either<Failure, void>> unfollow({required UserModel user});

  Stream<bool> userIsInFollowing({required String uId});

  Stream<bool> userIsInFollowers({required String uId});
}
