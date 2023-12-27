import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/profile/domain/entities/update_user_params.dart';

abstract class EditProfileRepo {
  Future<Either<Failure, void>> updateUser({
    required UpdateUserParams updateUserParams,
  });

  Future<Either<Failure, XFile?>> getImage({required ImageSource source});

  Future<Either<Failure, TaskSnapshot>> uploadImage({File? image});
}
