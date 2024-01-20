import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/features/posts/data/models/like_model.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class PersonWhoLiked extends StatelessWidget {
  const PersonWhoLiked({
    super.key,
    required this.like,
  });

  final LikeModel like;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 0),
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Helper.isDark(context)
            ? AppColors.darkPrimaryColor
            : AppColors.lightWhiteBlue,
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          BlocProvider.of<UserCubit>(context)
              .getUserPosts(uId: like.user!.uId!)
              .then((value) {
            context.navigateTo(
              routeName: Routes.userProfileRoute,
              arguments: like.user,
            );
          });
        },
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                errorWidget: (context, error, _) =>
                    const CachedImageErrorIcon(),
                imageUrl: like.user!.image!,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      like.user!.name!,
                      style: AppTextStyles.textStyle16SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      like.user!.email!,
                      style: AppTextStyles.textStyle13.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
