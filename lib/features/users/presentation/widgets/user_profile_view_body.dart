import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/user_data.dart';
import 'package:social_app/service_locator.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.3,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(5.r),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(user.cover!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: user.image!,
                    imageBuilder: (_, image) {
                      return BlocBuilder<ThemesCubit, ThemeData>(
                        builder: (context, state) {
                          return CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Helper.isDark(state)
                                ? AppColors.darkGreyClr
                                : AppColors.scaffoldBackgroundClr,
                            child: CircleAvatar(
                              backgroundImage: image,
                              radius: 55.r,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
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
              child: const Row(
                children: <Widget>[
                  UserData(count: 0, label: "Posts"),
                  UserData(count: 0, label: "Photos"),
                  UserData(count: 0, label: "Followers"),
                  UserData(count: 0, label: "Following"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
