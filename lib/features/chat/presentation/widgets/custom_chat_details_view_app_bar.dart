import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/custom_circle_icon_button.dart';
import 'package:social_app/core/widgets/username.dart';
import 'package:social_app/core/widgets/username_and_verification_icon.dart';

class CustomChatDetailsViewAppBar extends StatelessWidget {
  const CustomChatDetailsViewAppBar({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () => Helper.navigateToUserProfile(user, context),
          child: Hero(
            tag: user.uId!,
            child: CachedNetworkImage(
              imageUrl: user.image!,
              errorWidget: (context, error, _) => const CachedImageErrorIcon(),
              imageBuilder: (_, image) {
                return CircleAvatar(
                  backgroundImage: image,
                  radius: 22.r,
                  backgroundColor: AppColors.primaryColor,
                );
              },
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              user.isEmailVerified!
                  ? UsernameAndVerificationIcon(user: user)
                  : Username(user: user),
              Text(
                user.email!,
                style: AppTextStyles.textStyle13.copyWith(
                  color: AppColors.lightGrey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w),
        CustomCircleIconButton(
          onPressed: () => context.back(),
          icon: Image.asset(AppAssets.iconsClose),
          backgroundColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
