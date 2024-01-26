import 'package:flutter/material.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';

abstract class LinkupDataSource {
  void changeBottomNavIndex({
    required ChangeIndexParams changeIndexParams,
  });

  void changeBottomNavToHome({required BuildContext context});

  List<Widget> getBody();
}
