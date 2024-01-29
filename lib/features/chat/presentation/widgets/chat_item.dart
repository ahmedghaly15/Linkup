import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/username.dart';
import 'package:social_app/core/widgets/username_and_verification_icon.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color:
            Helper.isDark(context) ? AppColors.darkPrimaryColor : Colors.white,
        boxShadow: <BoxShadow>[
          Helper.postShadow(context),
        ],
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          context.navigateTo(
            routeName: Routes.chatDetailsRoute,
            arguments: user,
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h),
          child: ListTile(
            leading: Hero(
              tag: user.uId!,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.image!),
                radius: 30.r,
                backgroundColor: AppColors.primaryColor,
              ),
            ),
            title: user.isEmailVerified!
                ? UsernameAndVerificationIcon(
                    user: user,
                    canNavigateToProfile: false,
                  )
                : Username(
                    user: user,
                    canNavigateToProfile: false,
                  ),
            subtitle: Text(
              user.bio!,
              style: AppTextStyles.textStyle13,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
