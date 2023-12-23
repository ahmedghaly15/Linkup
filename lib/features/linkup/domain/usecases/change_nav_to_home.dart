import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';
import 'package:social_app/features/linkup/domain/repositories/linkup_repo.dart';

class ChangeNavToHomeUseCase
    implements RegularUseCases<void, ChangeIndexParams> {
  final LinkupRepo linkupRepo;

  const ChangeNavToHomeUseCase({required this.linkupRepo});

  @override
  void call(ChangeIndexParams params) {
    linkupRepo.changeBottomNavToHome(changeIndexParams: params);
  }
}
