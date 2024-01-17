import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/user_data.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          user.name!,
          style: AppTextStyles.textStyle23Bold,
        ),
        SizedBox(height: 8.h),
        Text(
          user.bio!,
          style: AppTextStyles.textStyle15,
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.phone,
              color: Colors.grey,
              size: 18.w,
            ),
            SizedBox(width: 5.w),
            Text(
              user.phone!,
              style: AppTextStyles.textStyle15,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          child: Row(
            children: <Widget>[
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return UserData(
                    count: BlocProvider.of<UserCubit>(context).userPosts.length,
                    label: "Posts",
                  );
                },
              ),
              const UserData(count: 0, label: "Photos"),
              const UserData(count: 0, label: "Followers"),
              const UserData(count: 0, label: "Following"),
            ],
          ),
        ),
      ],
    );
  }
}
