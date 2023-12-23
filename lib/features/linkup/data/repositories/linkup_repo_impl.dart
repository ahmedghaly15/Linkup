import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/linkup/data/datasources/linkup_datasource.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';
import 'package:social_app/features/linkup/domain/repositories/linkup_repo.dart';

class LinkupRepoImpl implements LinkupRepo {
  final LinkupDataSource linkupDataSource;

  const LinkupRepoImpl({required this.linkupDataSource});

  @override
  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>> getUserData({
    String? uId,
  }) {
    return executeAndHandleErrors<DocumentSnapshot<Map<String, dynamic>>>(
      function: () => linkupDataSource.getUserData(uId: uId),
    );
  }

  @override
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getAllUsers() {
    return executeAndHandleErrors<QuerySnapshot<Map<String, dynamic>>>(
      function: () => linkupDataSource.getAllUsers(),
    );
  }

  @override
  void changeBottomNavIndex({required ChangeIndexParams changeIndexParams}) {
    linkupDataSource.changeBottomNavIndex(changeIndexParams: changeIndexParams);
  }

  @override
  void changeBottomNavToHome({required ChangeIndexParams changeIndexParams}) {
    linkupDataSource.changeBottomNavToHome(
      changeIndexParams: changeIndexParams,
    );
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
