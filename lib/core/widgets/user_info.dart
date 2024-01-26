import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/widgets/social_icons.dart';
import 'package:social_app/features/users/presentation/widgets/followers_and_following.dart';
import 'package:social_app/features/users/presentation/widgets/following_and_message_buttons.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      child: Column(
        children: <Widget>[
          FollowersAndFollowing(user: user),
          SizedBox(height: 10.h),
          Text(
            user.name!,
            style: AppTextStyles.textStyle17Bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Helper.isDark(context)
                    ? AppAssets.iconsGreyProfileEmail
                    : AppAssets.iconsProfileEmail,
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  user.email!,
                  style: AppTextStyles.textStyle13.copyWith(
                    color: Helper.isDark(context)
                        ? Colors.white54
                        : AppColors.lightGrey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            user.bio!,
            style: AppTextStyles.textStyle13.copyWith(
              color:
                  Helper.isDark(context) ? Colors.white54 : AppColors.lightGrey,
            ),
            maxLines: null,
            textAlign: TextAlign.center,
          ),
          if (user.xUrl != AppStrings.xUrl ||
              user.facebookUrl != AppStrings.facebookUrl ||
              user.instagramUrl != AppStrings.instagramUrl ||
              user.githubUrl != AppStrings.githubUrl) ...[
            SizedBox(height: 8.h),
            SocialIcons(user: user),
          ],
          if (user.uId! != Helper.currentUser!.uId) ...[
            SizedBox(height: 10.h),
            FollowingAndMessageButtons(user: user),
          ],
        ],
      ),
    );
  }
}
