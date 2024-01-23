import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_followers/get_followers_cubit.dart';
import 'package:social_app/features/users/presentation/widgets/empty_user_view.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/follower_user_item.dart';

class FollowersTab extends StatelessWidget {
  const FollowersTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: CustomScrollView(
        physics: AppConstants.physics,
        slivers: [
          BlocBuilder<GetFollowersCubit, GetFollowersState>(
            builder: (context, state) {
              final GetFollowersCubit cubit =
                  BlocProvider.of<GetFollowersCubit>(context);

              if (state is GetFollowersSuccess) {
                return state.followers.isNotEmpty
                    ? SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 210.w,
                            mainAxisExtent: 210.h,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 16.w,
                            childAspectRatio: 3 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
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
                            childCount: state.followers.length,
                          ),
                        ),
                      )
                    : const EmptyUsersView();
              } else if (state is GetFollowersError) {
                return SliverFillRemaining(
                  child: CustomErrorWidget(
                    onPressed: () => cubit.getFollowers(),
                    error: state.error,
                  ),
                );
              } else {
                return const SliverFillRemaining(
                  child: BodyLoadingIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
