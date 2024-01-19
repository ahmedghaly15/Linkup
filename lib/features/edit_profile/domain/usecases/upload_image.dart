import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';

class UploadImageUseCase implements BaseUseCases<TaskSnapshot, File?> {
  final EditProfileRepo editProfileRepo;

  const UploadImageUseCase({required this.editProfileRepo});

  @override
  Future<Either<Failure, TaskSnapshot>> call(File? params) async {
    return await editProfileRepo.uploadImage(image: params);
  }
}
