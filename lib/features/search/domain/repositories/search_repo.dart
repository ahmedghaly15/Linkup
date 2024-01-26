import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<UserModel>>> search({
    required String nameOrEmail,
  });
}
