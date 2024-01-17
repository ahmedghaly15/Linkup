import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';
import 'package:social_app/core/widgets/user_cover_image.dart';
import 'package:social_app/core/widgets/user_information.dart';
import 'package:social_app/core/widgets/user_posts.dart';
import 'package:social_app/core/widgets/user_profile_image.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: CustomScrollView(
        physics: AppConstants.physics,
        slivers: [
          SliverAppBar(
            leading: GetBackArrow(
              onPressed: () {
                BlocProvider.of<PostsCubit>(context).getPosts();
                context.back();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.3,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      UserCoverImage(cover: user.cover!),
                      UserProfileImage(image: user.image!),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                UserInformation(user: user),
              ],
            ),
          ),
          UserPosts(uId: user.uId!),
        ],
      ),
    );
  }
}
