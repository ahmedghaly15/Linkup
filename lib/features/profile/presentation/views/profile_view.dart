import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/widgets/custom_get_back_button.dart';
import 'package:social_app/core/widgets/user_profile_content.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';
import 'package:social_app/features/profile/presentation/widgets/custom_pop_menu_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          AppAssets.imagesProfileBackground,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomGetBackButton(
                        onPressed: () {
                          BlocProvider.of<LinkupCubit>(context)
                              .changeBottomNavToHome(context);
                        },
                      ),
                      const CustomPopMenuButton(),
                    ],
                  ),
                ),
                SizedBox(height: 77.h),
                UserProfileContent(user: Helper.currentUser!),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
