import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';

class UserIsFollowedUseCase
    implements RegularUseCases<Stream<bool>, UserModel> {
  final UserRepo userRepo;

  const UserIsFollowedUseCase({required this.userRepo});

  @override
  Stream<bool> call(UserModel params) {
    return userRepo.userIsFollowed(user: params);
  }
}
