import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final UserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      enableSuggestions: true,
      keyboardType: TextInputType.name,
      cursorColor: Colors.grey,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: "Name...",
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
        contentPadding: EdgeInsets.all(8.h),
      ),
      onChanged: (value) {
        cubit.search(value: value);
      },
    );
  }
}