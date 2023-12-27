import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/profile/domain/repositories/edit_profile_repo.dart';

class GetImageUseCase implements BaseUseCases<XFile?, ImageSource> {
  final EditProfileRepo editProfileRepo;

  const GetImageUseCase({required this.editProfileRepo});

  @override
  Future<Either<Failure, XFile?>> call(ImageSource params) async {
    return await editProfileRepo.getImage(source: params);
  }
}
