import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';

abstract class BaseUseCases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
