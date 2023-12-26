import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/chat/domain/entities/send_message_params.dart';
import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class SendMessageUseCase implements BaseUseCases<void, SendMessageParams> {
  final ChatRepo chatRepo;

  const SendMessageUseCase({required this.chatRepo});

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return await chatRepo.sendMessage(sendMessageParams: params);
  }
}
