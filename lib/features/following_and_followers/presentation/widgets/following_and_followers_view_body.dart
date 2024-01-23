import 'package:flutter/material.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/followers_tab.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/following_tab.dart';

class FollowingAndFollowersViewBody extends StatelessWidget {
  const FollowingAndFollowersViewBody({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const <Widget>[
        FollowersTab(),
        FollowingTab(),
      ],
    );
  }
}
