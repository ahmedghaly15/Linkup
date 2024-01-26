import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_followers/get_followers_cubit.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, this.hintText = 'Name...'});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      enableSuggestions: true,
      keyboardType: TextInputType.name,
      cursorColor: Colors.grey,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey[700],
          letterSpacing: 0.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      ),
      onChanged: (value) {
        BlocProvider.of<GetFollowersCubit>(context).search(value: value);
      },
    );
  }
}
