import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class UploadMessageImageUseCase implements BaseUseCases<TaskSnapshot, File?> {
  final ChatRepo chatRepo;

  const UploadMessageImageUseCase({required this.chatRepo});

  @override
  Future<Either<Failure, TaskSnapshot>> call(File? params) async {
    return await chatRepo.uploadMessageImage(messageImage: params);
  }
}
