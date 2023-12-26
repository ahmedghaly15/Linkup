import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class GetMessagesUseCase
    implements
        RegularUseCases<Stream<QuerySnapshot<Map<String, dynamic>>>, String> {
  final ChatRepo chatRepo;

  const GetMessagesUseCase({required this.chatRepo});

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> call(String params) {
    return chatRepo.getMessages(receiverId: params);
  }
}
