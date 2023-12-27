import 'package:flutter/material.dart';
import 'package:social_app/features/linkup/data/datasources/linkup_datasource.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';
import 'package:social_app/features/linkup/domain/repositories/linkup_repo.dart';

class LinkupRepoImpl implements LinkupRepo {
  final LinkupDataSource linkupDataSource;

  const LinkupRepoImpl({required this.linkupDataSource});

  @override
  void changeBottomNavIndex({required ChangeIndexParams changeIndexParams}) {
    linkupDataSource.changeBottomNavIndex(changeIndexParams: changeIndexParams);
  }

  @override
  void changeBottomNavToHome({required BuildContext context}) {
    linkupDataSource.changeBottomNavToHome(context: context);
  }

  @override
  List<Widget> getBody() {
    return linkupDataSource.getBody();
  }

  @override
  List<BottomNavigationBarItem> getBottomNavItems() {
    return linkupDataSource.getBottomNavItems();
  }
}
