import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/chat/presentation/views/chats_view.dart';
import 'package:social_app/features/linkup/data/datasources/linkup_datasource.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';
import 'package:social_app/features/posts/presentation/views/posts_view.dart';
import 'package:social_app/features/profile/presentation/views/me_view.dart';
import 'package:social_app/features/users/presentation/views/users_view.dart';
import 'package:social_app/service_locator.dart';

class LinkupDataSourceImpl implements LinkupDataSource {
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.uId)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .get();
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
      PostsView(),
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
