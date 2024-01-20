import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/main_button.dart';

class CurrentUserInfo extends StatelessWidget {
  const CurrentUserInfo({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '1K',
                    style: AppTextStyles.textStyle15.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Followers',
                    style: AppTextStyles.textStyle13,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '1K',
                    style: AppTextStyles.textStyle15.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Followers',
                    style: AppTextStyles.textStyle13,
                  ),
                ],
              ),
            ],
          ),
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
              Image.asset(AppAssets.iconsEmail),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  user.email!,
                  style: AppTextStyles.textStyle13.copyWith(
                    color: AppColors.lightGrey,
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
              color: AppColors.lightGrey,
            ),
            maxLines: null,
          ),
          if (user.uId! != Helper.currentUser!.uId) ...[
            SizedBox(height: 10.h),
            Row(
              children: <Widget>[
                Expanded(
                  child: MainButton(
                    text: 'Follow',
                    onPressed: () {},
                    borderRadius: 20,
                    boxShadow: <BoxShadow>[
                      Helper.buttonShadow(
                        AppColors.primaryColor.withOpacity(0.5),
                      ),
                    ],
                    textStyle: AppTextStyles.textStyle13.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: MainButton(
                    text: 'Message',
                    onPressed: () {
                      context.navigateTo(
                        routeName: Routes.chatDetailsRoute,
                        arguments: user,
                      );
                    },
                    borderRadius: 20,
                    backgroundColor: Helper.isDark(context)
                        ? AppColors.darkPrimaryColor
                        : Colors.white,
                    textStyle: AppTextStyles.textStyle13.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    boxShadow: <BoxShadow>[
                      Helper.buttonShadow(
                        Colors.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
