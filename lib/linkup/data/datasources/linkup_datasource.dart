import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/linkup/domain/entities/change_index_params.dart';

abstract class LinkupDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData({String? uId});

  void changeBottomNavIndex({
    required ChangeIndexParams changeIndexParams,
  });

  void changeBottomNavToHome({required ChangeIndexParams changeIndexParams});

  List<Widget> getBody();

  List<BottomNavigationBarItem> getBottomNavItems();
}
