import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_following/get_following_cubit.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/empty_following.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/following_user_item.dart';
import 'package:social_app/features/following_and_followers/presentation/widgets/shimmer_following_tab.dart';

class FollowingTab extends StatelessWidget {
  const FollowingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFollowingCubit, GetFollowingState>(
      builder: (context, state) {
        final GetFollowingCubit cubit =
            BlocProvider.of<GetFollowingCubit>(context);

        if (state is GetFollowingSuccess) {
          return state.following.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: ListView.builder(
                    itemCount: state.following.length,
                    physics: AppConstants.physics,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 650),
                        child: SlideAnimation(
                          horizontalOffset: 150,
                          child: FollowingUserItem(
                            user: state.following[index],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const EmptyFollowing();
        } else if (state is GetFollowingError) {
          return CustomErrorWidget(
            onPressed: () => cubit.getFollowing(),
            error: state.error,
          );
        } else {
          return const ShimmerFollowingTab();
        }
      },
    );
  }
}
