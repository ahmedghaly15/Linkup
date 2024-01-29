import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/username.dart';
import 'package:social_app/core/widgets/username_and_verification_icon.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/following_and_followers_cubit.dart';

class FollowingUserItem extends StatelessWidget {
  const FollowingUserItem({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if (user.uId! != Helper.currentUser!.uId) {
          Helper.navigateToUserProfile(user, context);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              errorWidget: (context, error, _) => const CachedImageErrorIcon(),
              imageUrl: user.image!,
              imageBuilder: (_, image) {
                return CircleAvatar(
                  backgroundImage: image,
                  radius: 25.r,
                  backgroundColor: AppColors.primaryColor,
                );
              },
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  user.isEmailVerified!
                      ? UsernameAndVerificationIcon(
                          user: user,
                          canNavigateToProfile: false,
                        )
                      : Username(
                          user: user,
                          canNavigateToProfile: false,
                        ),
                  Text(
                    user.bio!,
                    style: AppTextStyles.textStyle13.copyWith(
                      color: Colors.grey,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            StreamBuilder<bool>(
              stream: BlocProvider.of<FollowingAndFollowersCubit>(context)
                  .userIsInFollowing(uId: user.uId!),
              builder: (context, snapshot) {
                bool isFollowed = snapshot.data ?? false;
                String buttonText = isFollowed ? 'Unfollow' : 'Follow';

                return OutlinedButton(
                  onPressed: () => isFollowed
                      ? BlocProvider.of<FollowingAndFollowersCubit>(context)
                          .unfollow(user: user)
                      : BlocProvider.of<FollowingAndFollowersCubit>(context)
                          .follow(user: user),
                  style: ButtonStyle(
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.w,
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      isFollowed
                          ? (Helper.isDark(context)
                              ? AppColors.darkPrimaryColor
                              : AppColors.lightWhiteBlue)
                          : AppColors.primaryColor,
                    ),
                    textStyle: MaterialStatePropertyAll(
                      AppTextStyles.textStyle13
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    foregroundColor: MaterialStatePropertyAll(
                      isFollowed ? AppColors.primaryColor : Colors.white,
                    ),
                  ),
                  child: Text(buttonText),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
