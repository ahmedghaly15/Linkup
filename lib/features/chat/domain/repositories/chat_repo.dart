import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/chat/domain/entities/send_message_params.dart';

abstract class ChatRepo {
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String receiverId,
  });

  Future<Either<Failure, void>> sendMessage({
    required SendMessageParams sendMessageParams,
  });

  Future<Either<Failure, XFile?>> getMessageImage({
    required ImageSource source,
  });

  Future<Either<Failure, TaskSnapshot>> uploadMessageImage({
    File? messageImage,
  });
}
