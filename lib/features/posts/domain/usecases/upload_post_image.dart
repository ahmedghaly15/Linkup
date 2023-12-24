import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/posts/domain/repositories/posts_repo.dart';

class UploadPostImageUseCase implements BaseUseCases<TaskSnapshot, File?> {
  final PostsRepo postsRepo;

  const UploadPostImageUseCase({required this.postsRepo});

  @override
  Future<Either<Failure, TaskSnapshot>> call(File? params) async {
    return await postsRepo.uploadPostImage(postImage: params);
  }
}
