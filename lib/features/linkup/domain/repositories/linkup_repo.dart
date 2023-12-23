import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';

abstract class LinkupRepo {
  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> getAllUsers();

  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>> getUserData({
    String? uId,
  });

  void changeBottomNavIndex({required ChangeIndexParams changeIndexParams});

  void changeBottomNavToHome({required ChangeIndexParams changeIndexParams});

  List<Widget> getBody();

  List<BottomNavigationBarItem> getBottomNavItems();
}
