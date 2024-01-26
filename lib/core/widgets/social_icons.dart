import 'package:flutter/material.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/widgets/social_icon.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (user.xUrl != AppStrings.xUrl)
          SocialIcon(
            url: user.xUrl!,
            lightModeIcon: AppAssets.iconsX,
            darkModeIcon: AppAssets.iconsDarkX,
          ),
        if (user.facebookUrl != AppStrings.facebookUrl)
          SocialIcon(
            url: user.facebookUrl!,
            darkModeIcon: AppAssets.iconsDarkFacebook,
            lightModeIcon: AppAssets.iconsFacebook,
          ),
        if (user.instagramUrl != AppStrings.instagramUrl)
          SocialIcon(
            url: user.instagramUrl!,
            darkModeIcon: AppAssets.iconsDarkInstagramAlt,
            lightModeIcon: AppAssets.iconsInstagram,
          ),
        if (user.githubUrl != AppStrings.githubUrl)
          SocialIcon(
            url: user.githubUrl!,
            darkModeIcon: AppAssets.iconsDarkGithub,
            lightModeIcon: AppAssets.iconsGithub,
          ),
      ],
    );
  }
}
