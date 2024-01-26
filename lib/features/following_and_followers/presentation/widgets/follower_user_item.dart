import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/features/users/presentation/cubits/user_profile/user_profile_cubit.dart';

class FollowerUserItem extends StatelessWidget {
  const FollowerUserItem({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color:
            Helper.isDark(context) ? AppColors.darkPrimaryColor : Colors.white,
        boxShadow: <BoxShadow>[
          Helper.postShadow(context),
        ],
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          BlocProvider.of<UserProfileCubit>(context)
              .getUserPosts(uId: user.uId!)
              .then((value) {
            context.navigateTo(
              routeName: Routes.userProfileRoute,
              arguments: user,
            );
          });
        },
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: user.image!,
              imageBuilder: (_, image) {
                return CircleAvatar(
                  backgroundImage: image,
                  radius: 55.r,
                  backgroundColor: AppColors.primaryColor,
                );
              },
              errorWidget: (context, error, _) => const CachedImageErrorIcon(),
            ),
            SizedBox(height: 8.h),
            Flexible(
              child: Text(
                user.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.textStyle16SemiBold,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.touch_app,
                  color: Helper.isDark(context)
                      ? Colors.white
                      : AppColors.primaryColor,
                  size: 22.w,
                ),
                SizedBox(width: 5.w),
                Text(
                  "Visit",
                  style: AppTextStyles.textStyle16.copyWith(
                    color: Helper.isDark(context)
                        ? Colors.white
                        : AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
