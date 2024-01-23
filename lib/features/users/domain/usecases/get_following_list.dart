import 'package:dartz/dartz.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';

class GetFollowingListUseCase
    implements BaseUseCases<List<UserModel>, NoParams> {
  final UserRepo userRepo;

  const GetFollowingListUseCase({required this.userRepo});

  @override
  Future<Either<Failure, List<UserModel>>> call(
    NoParams params,
  ) async {
    return await userRepo.getFollowersList();
  }
}
