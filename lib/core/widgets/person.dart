import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/username.dart';
import 'package:social_app/core/widgets/username_and_verification_icon.dart';

class Person extends StatelessWidget {
  const Person({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 0),
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Helper.isDark(context)
            ? AppColors.darkPrimaryColor
            : AppColors.lightWhiteBlue,
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          if (user.uId! != Helper.currentUser!.uId) {
            Helper.navigateToUserProfile(user, context);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                errorWidget: (context, error, _) =>
                    const CachedImageErrorIcon(),
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
                      user.email!,
                      style: AppTextStyles.textStyle13.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
