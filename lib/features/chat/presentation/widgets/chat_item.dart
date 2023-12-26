import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_text_styles.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemeData>(
      builder: (context, state) {
        return Card(
          color: state.brightness == Brightness.dark
              ? AppColors.darkGreyClr
              : Colors.white,
          margin: EdgeInsets.symmetric(vertical: 4.h),
          elevation: 1.5.h,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              //   AppNavigator.navigateTo(
              //   screen: ChatDetailsView(userModel: model),
              // );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h),
              child: ListTile(
                leading: Hero(
                  tag: user.uId!,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.image!),
                    radius: 25.r,
                    backgroundColor: AppColors.primaryColor,
                  ),
                ),
                title: Text(
                  user.name!,
                  style: AppTextStyles.textStyle18Bold,
                ),
                subtitle: Text(
                  user.bio!,
                  style: AppTextStyles.textStyle13,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
