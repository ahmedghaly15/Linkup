import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class CustomPopMenuButton extends StatelessWidget {
  const CustomPopMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) => _handleSignOutState(state, context),
        builder: (context, state) {
          return PopupMenuButton(
            icon: Container(
              height: 44.h,
              width: 44.h,
              decoration: const BoxDecoration(
                color: AppColors.lightWhiteBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.more_vert,
                color: AppColors.iconsColor,
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'theme',
                child: Text(
                  Helper.isDark(context) ? 'Light mode' : 'Dark mode',
                  style: AppTextStyles.textStyle16SemiBold,
                ),
              ),
              PopupMenuItem(
                value: 'editProfile',
                child: Text(
                  'Edit Profile',
                  style: AppTextStyles.textStyle16SemiBold,
                ),
              ),
              PopupMenuItem(
                value: 'signOut',
                child: Text(
                  'Sign Out',
                  style: AppTextStyles.textStyle16SemiBold,
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'editProfile') {
                context.navigateTo(routeName: Routes.editProfileRoute);
              }

              if (value == 'signOut') {
                BlocProvider.of<UserCubit>(context).signOut();
              }

              if (value == 'theme') {
                BlocProvider.of<ThemesCubit>(context).toggleTheme();
              }
            },
          );
        });
  }

  void _handleSignOutState(UserState state, BuildContext context) {
    if (state is UserSignOutSuccess) {
      context.navigateAndReplace(newRoute: Routes.signInRoute);
    }
  }
}
