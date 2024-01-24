import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_followers/get_followers_cubit.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/shimmer_followers_tab.dart';
import 'package:social_app/features/users/presentation/widgets/empty_user_view.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/follower_user_item.dart';

class FollowersTab extends StatelessWidget {
  const FollowersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: BlocBuilder<GetFollowersCubit, GetFollowersState>(
        builder: (context, state) {
          final GetFollowersCubit cubit =
              BlocProvider.of<GetFollowersCubit>(context);

          if (state is GetFollowersSuccess) {
            return state.followers.isNotEmpty
                ? GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    physics: AppConstants.physics,
                    gridDelegate: Helper.followersGridViewGridDelegate(),
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 650),
                        columnCount: state.followers.length,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: FollowerUserItem(
                              user: state.followers[index],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: state.followers.length,
                  )
                : const EmptyUsersView();
          } else if (state is GetFollowersError) {
            return CustomErrorWidget(
              onPressed: () => cubit.getFollowers(),
              error: state.error,
            );
          } else {
            return const ShimmerFollowersTab();
          }
        },
      ),
    );
  }
}
