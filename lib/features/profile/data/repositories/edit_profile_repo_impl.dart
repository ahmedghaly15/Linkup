import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/profile/data/datasources/edit_profile_datasource.dart';
import 'package:social_app/features/profile/domain/entities/update_user_params.dart';
import 'package:social_app/features/profile/domain/repositories/edit_profile_repo.dart';

class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileDataSource editProfileDataSource;

  const EditProfileRepoImpl({required this.editProfileDataSource});

  @override
  Future<Either<Failure, void>> updateUser({
    required UpdateUserParams updateUserParams,
  }) {
    final UserModel userModel = UserModel(
      name: updateUserParams.name,
      phone: updateUserParams.phone,
      bio: updateUserParams.bio,
      image: updateUserParams.image ?? Helper.currentUser!.image,
      cover: updateUserParams.cover ?? Helper.currentUser!.cover,
      email: Helper.currentUser!.email,
      uId: Helper.currentUser!.uId,
      isEmailVerified: false,
    );

    return executeAndHandleErrors<void>(
      function: () => editProfileDataSource.updateUser(
        userModel: userModel,
      ),
    );
  }
}
