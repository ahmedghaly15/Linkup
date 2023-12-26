part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class GetMessagesSuccess extends ChatState {
  final List<MessageModel> messages;

  const GetMessagesSuccess({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class GetMessagesError extends ChatState {
  final String error;

  const GetMessagesError({required this.error});

  @override
  List<Object?> get props => [error];
}

class SendMessageSuccess extends ChatState {
  const SendMessageSuccess();
}

class SendMessageError extends ChatState {
  final String error;

  const SendMessageError({required this.error});

  @override
  List<Object?> get props => [error];
}

class MessageImagePickedSuccess extends ChatState {
  final File messageImage;

  const MessageImagePickedSuccess({required this.messageImage});

  @override
  List<Object?> get props => [messageImage];
}

class MessageImagePickedError extends ChatState {
  final String error;

  const MessageImagePickedError({required this.error});

  @override
  List<Object?> get props => [error];
}

class UploadMessageImageLoading extends ChatState {
  const UploadMessageImageLoading();
}

class UploadMessageImageSuccess extends ChatState {
  final String imageUrl;

  const UploadMessageImageSuccess({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class UploadMessageImageError extends ChatState {
  final String error;

  const UploadMessageImageError({required this.error});

  @override
  List<Object?> get props => [error];
}

class RemovedMessageImageSuccess extends ChatState {
  const RemovedMessageImageSuccess();
}
