import 'package:flutter/material.dart';
import 'package:social_app/core/entities/no_params.dart';
import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/linkup/domain/repositories/linkup_repo.dart';

class GetBodyUseCse implements RegularUseCases<List<Widget>, NoParams> {
  final LinkupRepo linkupRepo;

  const GetBodyUseCse({required this.linkupRepo});

  @override
  List<Widget> call(NoParams params) {
    return linkupRepo.getBody();
  }
}
