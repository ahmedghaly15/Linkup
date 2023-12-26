import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/usecases/base_usecase.dart';
import 'package:social_app/features/chat/domain/repositories/chat_repo.dart';

class GetMessageImageUseCase implements BaseUseCases<XFile?, ImageSource> {
  final ChatRepo chatRepo;

  const GetMessageImageUseCase({required this.chatRepo});

  @override
  Future<Either<Failure, XFile?>> call(ImageSource params) async {
    return await chatRepo.getMessageImage(source: params);
  }
}
