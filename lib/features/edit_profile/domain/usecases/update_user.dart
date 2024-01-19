import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/edit_profile/domain/entities/update_user_params.dart';
import 'package:social_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';

class UpdateUserUseCase implements BaseUseCases<void, UpdateUserParams> {
  final EditProfileRepo editProfileRepo;

  const UpdateUserUseCase({required this.editProfileRepo});

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) async {
    return await editProfileRepo.updateUser(updateUserParams: params);
  }
}
