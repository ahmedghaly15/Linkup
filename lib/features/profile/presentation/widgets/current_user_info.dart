import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';

class CurrentUserInfo extends StatelessWidget {
  const CurrentUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            Helper.currentUser!.name!,
            style: AppTextStyles.textStyle17Bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            Helper.currentUser!.email!,
            style: AppTextStyles.textStyle13.copyWith(
              color: AppColors.lightGrey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            Helper.currentUser!.bio!,
            style: AppTextStyles.textStyle13.copyWith(
              color: AppColors.lightGrey,
            ),
            maxLines: null,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
