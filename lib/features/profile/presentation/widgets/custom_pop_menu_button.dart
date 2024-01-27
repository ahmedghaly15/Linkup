import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/features/profile/presentation/widgets/custom_confirm_action_dialog.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class CustomPopMenuButton extends StatelessWidget {
  const CustomPopMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) => _handleUserState(state, context),
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
                  style: _menuItemTextStyle,
                ),
              ),
              PopupMenuItem(
                value: 'editProfile',
                child: Text(
                  'Edit profile',
                  style: _menuItemTextStyle,
                ),
              ),
              PopupMenuItem(
                value: 'deleteAccount',
                child: Text(
                  'Delete account',
                  style: _menuItemTextStyle,
                ),
              ),
              PopupMenuItem(
                value: 'signOut',
                child: Text(
                  'Sign out',
                  style: _menuItemTextStyle,
                ),
              ),
            ],
            onSelected: (value) => _onSelected(value, context),
          );
        });
  }

  void _onSelected(String value, BuildContext context) {
    if (value == 'editProfile') {
      context.navigateTo(routeName: Routes.editProfileRoute);
    }

    if (value == 'signOut') {
      CustomConfirmActionDialog.show(
        context: context,
        outlineButtonOnPressed: () {
          BlocProvider.of<UserCubit>(context).signOut();
        },
        outlineButtonText: 'Sign out',
        message: 'Are you sure that you would like to sign out?',
      );
    }

    if (value == 'theme') {
      BlocProvider.of<ThemesCubit>(context).toggleTheme();
    }

    if (value == 'deleteAccount') {
      CustomConfirmActionDialog.show(
        context: context,
        outlineButtonOnPressed: () {
          BlocProvider.of<UserCubit>(context).deleteAccount();
        },
        cancelButtonBackgroundColor: Colors.red,
        outlineButtonBorderColor: Colors.red,
        outlineButtonText: 'Delete',
        message: 'Are you sure that you would like to delete your account?',
      );
    }
  }

  TextStyle get _menuItemTextStyle => AppTextStyles.textStyle16SemiBold;

  void _handleUserState(UserState state, BuildContext context) {
    if (state is UserSignOutSuccess) {
      _navigateToSignInRoute(context);
    }

    if (state is DeleteUserSuccess) {
      _navigateToSignInRoute(context);
    }
  }

  void _navigateToSignInRoute(BuildContext context) {
    context.navigateAndReplace(newRoute: Routes.signInRoute);
  }
}
