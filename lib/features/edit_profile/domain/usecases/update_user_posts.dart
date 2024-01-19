import 'package:dartz/dartz.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';

class UpdateUserPostsUseCase implements BaseUseCases<void, NoParams> {
  final EditProfileRepo editProfileRepo;

  const UpdateUserPostsUseCase({required this.editProfileRepo});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await editProfileRepo.updateUserPosts();
  }
}
