import 'package:flutter/widgets.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/linkup/domain/repositories/linkup_repo.dart';

class ChangeNavToHomeUseCase implements RegularUseCases<void, BuildContext> {
  final LinkupRepo linkupRepo;

  const ChangeNavToHomeUseCase({required this.linkupRepo});

  @override
  void call(BuildContext params) {
    linkupRepo.changeBottomNavToHome(context: params);
  }
}
