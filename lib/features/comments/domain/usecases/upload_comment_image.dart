import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/comments/domain/repositories/comments_repo.dart';

class UploadCommentImageUseCase implements BaseUseCases<TaskSnapshot, File?> {
  final CommentsRepo commentsRepo;

  const UploadCommentImageUseCase({required this.commentsRepo});

  @override
  Future<Either<Failure, TaskSnapshot>> call(File? params) async {
    return await commentsRepo.uploadCommentImage(commentImage: params);
  }
}
