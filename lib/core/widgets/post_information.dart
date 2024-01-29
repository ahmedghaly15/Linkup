import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/username.dart';
import 'package:social_app/core/widgets/username_and_verification_icon.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';

class PostInformation extends StatelessWidget {
  const PostInformation({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CachedNetworkImage(
          errorWidget: (context, error, _) => const CachedImageErrorIcon(),
          imageUrl: post.user!.image!,
          imageBuilder: (_, image) {
            return InkWell(
              onTap: () => Helper.navigateToUserProfile(post.user!, context),
              child: CircleAvatar(
                backgroundImage: image,
                radius: 20.r,
                backgroundColor: AppColors.primaryColor,
              ),
            );
          },
        ),
        SizedBox(width: 10.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              post.user!.isEmailVerified!
                  ? UsernameAndVerificationIcon(user: post.user!)
                  : Username(user: post.user!),
              Text(
                "${post.date} at ${post.time}",
                style: AppTextStyles.textStyle13.copyWith(
                  color: AppColors.lightGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
