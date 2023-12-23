import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/chat/presentation/views/chats_view.dart';
import 'package:social_app/features/feeds/presentation/views/feeds_view.dart';
import 'package:social_app/features/profile/presentation/views/me_view.dart';
import 'package:social_app/features/users/presentation/views/users_view.dart';
import 'package:social_app/linkup/data/datasources/linkup_datasource.dart';
import 'package:social_app/linkup/domain/entities/change_index_params.dart';
import 'package:social_app/linkup/presentation/cubits/linkup_cubit.dart';

class LinkupDataSourceImpl implements LinkupDataSource {
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData({
    String? uId,
  }) async {
    return await FirebaseFirestore.instance.collection('users').doc(uId).get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }

  @override
  void changeBottomNavIndex({
    required ChangeIndexParams changeIndexParams,
  }) {
    BlocProvider.of<LinkupCubit>(changeIndexParams.context!).currentIndex =
        changeIndexParams.index!;
  }

  @override
  void changeBottomNavToHome({required ChangeIndexParams changeIndexParams}) {
    BlocProvider.of<LinkupCubit>(changeIndexParams.context!).currentIndex = 0;
  }

  @override
  List<Widget> getBody() {
    return const <Widget>[
      FeedsView(),
      ChatsView(),
      UsersView(),
      MeView(),
    ];
  }

  @override
  List<BottomNavigationBarItem> getBottomNavItems() {
    return const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: "Chats",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.group_rounded),
        label: "Users",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Me",
      ),
    ];
  }
}
