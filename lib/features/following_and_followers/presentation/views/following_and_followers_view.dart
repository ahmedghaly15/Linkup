import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_followers/get_followers_cubit.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_following/get_following_cubit.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/following_and_followers_view_body.dart';

class FollowingAndFollowersView extends StatefulWidget {
  const FollowingAndFollowersView({super.key});

  @override
  State<FollowingAndFollowersView> createState() =>
      _FollowingAndFollowersViewState();
}

class _FollowingAndFollowersViewState extends State<FollowingAndFollowersView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFillingContainer(
      child: CustomContentContainer(
        bottomPadding: 16,
        child: Scaffold(
          backgroundColor: Helper.isDark(context)
              ? AppColors.darkPrimaryColor
              : AppColors.lightWhiteBlue,
          appBar: _followingAndFollowersAppBar(context),
          body: FollowingAndFollowersViewBody(tabController: _tabController),
        ),
      ),
    );
  }

  AppBar _followingAndFollowersAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 0,
      backgroundColor: Helper.isDark(context)
          ? AppColors.darkPrimaryColor
          : AppColors.lightWhiteBlue,
      elevation: 0,
      bottom: TabBar(
        onTap: (int index) => _onTapOnTabs(index, context),
        padding: EdgeInsets.zero,
        controller: _tabController,
        indicatorWeight: 4.h,
        indicatorPadding: EdgeInsets.only(bottom: 8.h),
        isScrollable: true,
        tabs: const <Widget>[
          Tab(text: 'Followers'),
          Tab(text: 'Following'),
        ],
      ),
    );
  }

  void _onTapOnTabs(int index, BuildContext context) {
    if (index == 0) {
      BlocProvider.of<GetFollowersCubit>(context).getFollowers();
    }

    if (index == 1) {
      BlocProvider.of<GetFollowingCubit>(context).getFollowing();
    }
  }
}
