import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/features/profile/presentation/widgets/current_user_info.dart';
import 'package:social_app/features/profile/presentation/widgets/current_user_posts.dart';

class UserProfileContent extends StatelessWidget {
  const UserProfileContent({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: CustomContentContainer(
            horizontalPadding: 0,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                AppConstants.contentContainerRadius.r,
              ),
            ),
            child: Column(
              children: <Widget>[
                CurrentUserInfo(user: user),
                SizedBox(height: 16.h),
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Helper.isDark(context)
                        ? AppColors.darkPrimaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50.r),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, -5.h),
                        blurRadius: 20.r,
                        spreadRadius: 0,
                        color: const Color(0xffD2DFE2),
                      ),
                    ],
                  ),
                  child: CurrentUserPosts(
                    uId: user.uId!,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -60.h,
          child: CachedNetworkImage(
            imageUrl: user.image!,
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
          ),
        )
      ],
    );
  }
}
