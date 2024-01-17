import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';

class UserNameAndImage extends StatelessWidget {
  const UserNameAndImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CachedNetworkImage(
          errorWidget: (context, error, _) => const CachedImageErrorIcon(),
          imageUrl: Helper.currentUser!.image!,
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
          child: Text(
            Helper.currentUser!.name!,
            style: AppTextStyles.textStyle20Bold,
          ),
        ),
      ],
    );
  }
}
