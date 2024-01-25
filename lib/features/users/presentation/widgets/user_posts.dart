import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/features/posts/presentation/widgets/empty_posts.dart';
import 'package:social_app/features/users/presentation/cubits/user_profile/user_profile_cubit.dart';
import 'package:social_app/features/users/presentation/widgets/shimmer_user_posts.dart';
import 'package:social_app/features/users/presentation/widgets/user_post_item.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({
    super.key,
    required this.uId,
  });

  final String uId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        final UserProfileCubit cubit =
            BlocProvider.of<UserProfileCubit>(context);

        if (state is GetUserPostsLoading) {
          return const ShimmerUserPosts();
        } else if (state is GetUserPostsError) {
          return CustomErrorWidget(
            onPressed: () => cubit.getUserPosts(uId: uId),
            error: state.error,
          );
        } else {
          return cubit.userPosts.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.only(top: 32.h, bottom: 32.h),
                  itemCount: cubit.userPosts.length,
                  shrinkWrap: true,
                  // physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => UserPostItem(
                    post: cubit.userPosts[index],
                  ),
                  separatorBuilder: (context, state) => SizedBox(height: 24.h),
                )
              : const EmptyPosts();
        }
      },
    );
  }
}
