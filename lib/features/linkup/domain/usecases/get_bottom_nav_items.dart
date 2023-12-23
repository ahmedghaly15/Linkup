import 'package:flutter/material.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/linkup/domain/repositories/linkup_repo.dart';

class GetBottomNavItemsUseCase
    implements RegularUseCases<List<BottomNavigationBarItem>, NoParams> {
  final LinkupRepo linkupRepo;

  const GetBottomNavItemsUseCase({required this.linkupRepo});

  @override
  List<BottomNavigationBarItem> call(NoParams params) {
    return linkupRepo.getBottomNavItems();
  }
}
