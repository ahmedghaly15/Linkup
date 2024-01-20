import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/core/widgets/custom_circle_icon_button.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

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
          onTap: () {
            BlocProvider.of<UserCubit>(context)
                .getUserPosts(uId: user.uId!)
                .then((value) {
              context.navigateTo(
                routeName: Routes.userProfileRoute,
                arguments: user,
              );
            });
          },
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
              Text(
                user.name!,
                style: AppTextStyles.textStyle18Bold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
