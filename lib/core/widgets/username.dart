import 'package:flutter/material.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';

class Username extends StatelessWidget {
  const Username({
    super.key,
    required this.user,
    this.canNavigateToProfile = true,
  });

  final UserModel user;
  final bool canNavigateToProfile;

  @override
  Widget build(BuildContext context) {
    return canNavigateToProfile
        ? InkWell(
            onTap: () => Helper.navigateToUserProfile(user, context),
            child: CustomName(user: user),
          )
        : CustomName(user: user);
  }
}

class CustomName extends StatelessWidget {
  const CustomName({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Text(
      user.name!,
      style: AppTextStyles.textStyle17Bold,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
