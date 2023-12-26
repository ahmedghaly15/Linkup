import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/chat/data/models/message_model.dart';
import 'package:social_app/features/chat/domain/entities/send_message_params.dart';
import 'package:social_app/features/chat/domain/usecases/get_message_image.dart';
import 'package:social_app/features/chat/domain/usecases/get_messages.dart';
import 'package:social_app/features/chat/domain/usecases/send_message.dart';
import 'package:social_app/features/chat/domain/usecases/upload_message_image.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final GetMessageImageUseCase getMessageImageUseCase;
  final UploadMessageImageUseCase uploadMessageImageUseCase;

  ChatCubit({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.getMessageImageUseCase,
    required this.uploadMessageImageUseCase,
  }) : super(const ChatInitial());

  List<MessageModel> messages = <MessageModel>[];

  void getMessages({required String receiverId}) {
    getMessagesUseCase(receiverId).listen((event) {
      messages.clear();

      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }

      emit(GetMessagesSuccess(messages: messages));
    }).onError((error) {
      emit(GetMessagesError(error: error.toString()));
    });
  }

  void sendMessage({required SendMessageParams params}) {
    sendMessageUseCase(params).then((value) {
      value.fold(
        (failure) => emit(
          SendMessageError(error: failure.failureMsg.toString()),
        ),
        (success) => emit(const SendMessageSuccess()),
      );
    });
  }

  File? messageImage;

  void getMessageImage({required ImageSource source}) {
    getMessageImageUseCase(source).then((value) {
      value.fold(
        (failure) => emit(
          MessageImagePickedError(error: failure.failureMsg.toString()),
        ),
        (image) {
          if (image != null) {
            messageImage = File(image.path);
          }

          emit(MessageImagePickedSuccess(messageImage: messageImage!));
        },
      );
    });
  }

  void uploadMessageImage({required SendMessageParams params}) {
    emit(const UploadMessageImageLoading());

    uploadMessageImageUseCase(messageImage).then((value) {
      value.fold(
        (failure) => emit(
          UploadMessageImageError(error: failure.failureMsg.toString()),
        ),
        (result) {
          result.ref.getDownloadURL().then((value) {
            sendMessage(
              params: SendMessageParams(
                receiverId: params.receiverId,
                receiverName: params.receiverName,
                date: params.date,
                time: params.time,
                text: params.text,
                messageImage: {
                  'image': value,
                  'height': 150,
                },
              ),
            );

            emit(UploadMessageImageSuccess(imageUrl: value));
          }).catchError((error) {
            emit(UploadMessageImageError(error: error.toString()));
          });
        },
      );
    });
  }

  void removeMessageImage() {
    messageImage = null;

    emit(const RemovedMessageImageSuccess());
  }
}
