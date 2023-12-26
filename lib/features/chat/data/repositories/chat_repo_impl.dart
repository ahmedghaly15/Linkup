import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/chat/data/datasources/chat_datasource.dart';
import 'package:social_app/features/chat/domain/entities/send_message_params.dart';
import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatDataSource chatDataSource;

  const ChatRepoImpl({required this.chatDataSource});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required String receiverId,
  }) {
    return chatDataSource.getMessages(receiverId: receiverId);
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required SendMessageParams sendMessageParams,
  }) {
    return executeAndHandleErrors<void>(
      function: () => chatDataSource.sendMessage(
        sendMessageParams: sendMessageParams,
      ),
    );
  }

  @override
  Future<Either<Failure, XFile?>> getMessageImage({
    required ImageSource source,
  }) {
    return executeAndHandleErrors<XFile?>(
      function: () => chatDataSource.getMessageImage(source: source),
    );
  }

  @override
  Future<Either<Failure, TaskSnapshot>> uploadMessageImage({
    File? messageImage,
  }) {
    return executeAndHandleErrors<TaskSnapshot>(
      function: () => chatDataSource.uploadMessageImage(
        messageImage: messageImage,
      ),
    );
  }
}
