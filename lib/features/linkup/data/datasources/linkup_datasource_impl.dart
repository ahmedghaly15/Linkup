import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/chat/presentation/views/chats_view.dart';
import 'package:social_app/features/linkup/data/datasources/linkup_datasource.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';
import 'package:social_app/features/posts/presentation/views/posts_view.dart';
import 'package:social_app/features/profile/presentation/views/profile_view.dart';
import 'package:social_app/features/following_and_followers/presentation/views/following_and_followers_view.dart';
import 'package:social_app/features/search/presentation/views/search_view.dart';

class LinkupDataSourceImpl implements LinkupDataSource {
  @override
  void changeBottomNavIndex({
    required ChangeIndexParams changeIndexParams,
  }) {
    BlocProvider.of<LinkupCubit>(changeIndexParams.context!).currentIndex =
        changeIndexParams.index!;
  }

  @override
  void changeBottomNavToHome({required BuildContext context}) {
    BlocProvider.of<LinkupCubit>(context).currentIndex = 0;
  }

  @override
  List<Widget> getBody() {
    return const <Widget>[
      PostsView(),
      ChatsView(),
      SearchView(),
      FollowingAndFollowersView(),
      ProfileView(),
    ];
  }
}
