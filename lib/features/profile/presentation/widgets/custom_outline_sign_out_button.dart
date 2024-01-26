import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class CustomOutlineSignOutButton extends StatelessWidget {
  const CustomOutlineSignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(
            16.0.r,
          ),
          color: Helper.isDark(context)
              ? AppColors.darkPrimaryColor
              : Colors.white,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1.w,
          ),
        ),
        child: MaterialButton(
          onPressed: () {
            BlocProvider.of<UserCubit>(context).signOut();
          },
          child: Text(
            'Sign out',
            style: AppTextStyles.textStyle18Bold,
          ),
        ),
      ),
    );
  }
}
