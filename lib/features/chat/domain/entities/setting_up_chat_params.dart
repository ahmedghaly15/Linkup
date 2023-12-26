import 'package:equatable/equatable.dart';
import 'package:social_app/features/chat/data/models/message_model.dart';

class SettingUpChatParams extends Equatable {
  final String receiverId;
  final MessageModel messageModel;

  const SettingUpChatParams({
    required this.receiverId,
    required this.messageModel,
  });

  @override
  List<Object?> get props => [receiverId, messageModel];
}
