import 'package:flutter/material.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';

abstract class LinkupRepo {
  void changeBottomNavIndex({required ChangeIndexParams changeIndexParams});

  void changeBottomNavToHome({required BuildContext context});

  List<Widget> getBody();
}
