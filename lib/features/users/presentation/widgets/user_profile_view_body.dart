import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';
import 'package:social_app/core/widgets/user_data.dart';
import 'package:social_app/core/widgets/user_posts.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<PostsCubit>(context).getPosts();
        return Future.value(true);
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: AppConstants.physics,
          slivers: [
            SliverAppBar(
              leading: GetBackArrow(
                onPressed: () {
                  BlocProvider.of<PostsCubit>(context).getPosts();
                  context.getBack();
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
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.r),
                                topRight: Radius.circular(5.r),
                              ),
                            ),
                            child: CachedNetworkImage(
                              height: screenHeight * 0.25,
                              width: double.infinity,
                              errorWidget: (context, error, _) =>
                                  const CachedImageErrorIcon(),
                              imageUrl: user.cover!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        CachedNetworkImage(
                          imageUrl: user.image!,
                          errorWidget: (context, error, _) =>
                              const CachedImageErrorIcon(),
                          imageBuilder: (_, image) {
                            return BlocBuilder<ThemesCubit, ThemeData>(
                              builder: (context, state) {
                                return CircleAvatar(
                                  radius: 60.r,
                                  backgroundColor: Helper.isDark(state)
                                      ? AppColors.darkGreyClr
                                      : AppColors.scaffoldBackgroundClr,
                                  child: CircleAvatar(
                                    backgroundImage: image,
                                    radius: 55.r,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    user.name!,
                    style: AppTextStyles.textStyle23Bold,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    user.bio!,
                    style: AppTextStyles.textStyle15,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: Colors.grey,
                        size: 18.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        user.phone!,
                        style: AppTextStyles.textStyle15,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    child: Row(
                      children: <Widget>[
                        BlocBuilder<UserCubit, UserState>(
                            builder: (context, state) {
                          return UserData(
                            count: BlocProvider.of<UserCubit>(context)
                                .userPosts
                                .length,
                            label: "Posts",
                          );
                        }),
                        const UserData(count: 0, label: "Photos"),
                        const UserData(count: 0, label: "Followers"),
                        const UserData(count: 0, label: "Following"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            UserPosts(uId: user.uId!),
          ],
        ),
      ),
    );
  }
}
