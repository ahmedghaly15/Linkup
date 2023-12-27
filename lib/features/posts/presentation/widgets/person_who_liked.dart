import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';
import 'package:social_app/features/posts/data/models/like_model.dart';

class PersonWhoLiked extends StatelessWidget {
  const PersonWhoLiked({
    super.key,
    required this.person,
  });

  final LikeModel person;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemeData>(
      builder: (context, state) {
        return Container(
          constraints: const BoxConstraints(minHeight: 0),
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: Helper.isDark(state) ? AppColors.darkGreyClr : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            border: Border.all(
              color: const Color(0xFFE3E3E4),
              width: 1,
            ),
          ),
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              //TODO: navigate to this user profile
            },
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    errorWidget: (context, error, _) =>
                        const CachedImageErrorIcon(),
                    imageUrl: person.profileImage!,
                    imageBuilder: (_, image) {
                      return CircleAvatar(
                        backgroundImage: image,
                        radius: 35.r,
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
                          person.name!,
                          style: AppTextStyles.textStyle18Bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          person.email!,
                          style: AppTextStyles.textStyle15.copyWith(
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
      },
    );
  }
}
