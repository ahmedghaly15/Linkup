import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';

abstract class FollowingAndFollowersRepo {
  Future<Either<Failure, List<UserModel>>> getFollowersList();

  Future<Either<Failure, List<UserModel>>> getFollowingList();

  Future<Either<Failure, void>> follow({required UserModel user});

  Future<Either<Failure, void>> unfollow({required UserModel user});

  Stream<bool> userIsFollowed({required UserModel user});
}
