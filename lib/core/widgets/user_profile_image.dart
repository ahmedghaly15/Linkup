import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      errorWidget: (context, error, _) => const CachedImageErrorIcon(),
      imageBuilder: (_, image) => CircleAvatar(
        radius: 60.r,
        backgroundColor: Helper.isDark(context)
            ? AppColors.darkPrimaryColor
            : AppColors.scaffoldBackgroundClr,
        child: CircleAvatar(
          backgroundImage: image,
          radius: 55.r,
        ),
      ),
    );
  }
}
