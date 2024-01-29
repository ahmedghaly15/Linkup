import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/widgets/username.dart';

class UsernameAndVerificationIcon extends StatelessWidget {
  const UsernameAndVerificationIcon({
    super.key,
    required this.user,
    this.canNavigateToProfile = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final UserModel user;
  final bool canNavigateToProfile;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Flexible(
          flex: 6,
          child: Username(
            user: user,
            canNavigateToProfile: canNavigateToProfile,
          ),
        ),
        SizedBox(width: 4.w),
        Flexible(
          child: Icon(
            Icons.verified,
            color: AppColors.primaryColor,
            size: 16.w,
          ),
        ),
      ],
    );
  }
}
