import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/widgets/main_button.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/following_and_followers_cubit.dart';

class FollowingAndMessageButtons extends StatelessWidget {
  const FollowingAndMessageButtons({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<bool>(
            stream: BlocProvider.of<FollowingAndFollowersCubit>(context)
                .userIsInFollowing(uId: user.uId!),
            builder: (context, snapshot) {
              bool isFollowed = snapshot.data ?? false;
              String buttonText = isFollowed ? 'Unfollow' : 'Follow';

              return MainButton(
                text: buttonText,
                onPressed: () => isFollowed
                    ? BlocProvider.of<FollowingAndFollowersCubit>(context)
                        .unfollow(user: user)
                    : BlocProvider.of<FollowingAndFollowersCubit>(context)
                        .follow(user: user),
                borderRadius: 32,
                boxShadow: <BoxShadow>[
                  Helper.buttonShadow(
                    AppColors.primaryColor.withOpacity(0.5),
                  ),
                ],
                textStyle: AppTextStyles.textStyle13.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: StreamBuilder<bool>(
            stream: BlocProvider.of<FollowingAndFollowersCubit>(context)
                .userIsInFollowers(uId: user.uId!),
            builder: (context, snapshot) {
              bool isInFollowers = snapshot.data ?? false;

              return MainButton(
                text: 'Message',
                onPressed: () => Helper.message(
                  isInFollowers: isInFollowers,
                  context: context,
                  user: user,
                ),
                borderRadius: 32,
                backgroundColor: Helper.isDark(context)
                    ? AppColors.darkHeaderClr
                    : Colors.white,
                textStyle: AppTextStyles.textStyle13.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                boxShadow: <BoxShadow>[
                  Helper.buttonShadow(
                    Colors.black.withOpacity(0.25),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
