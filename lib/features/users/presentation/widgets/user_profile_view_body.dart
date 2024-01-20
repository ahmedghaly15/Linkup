import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/custom_circle_icon_button.dart';
import 'package:social_app/core/widgets/custom_get_back_button.dart';
import 'package:social_app/core/widgets/user_profile_content.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({
    super.key,
    required this.user,
  });

  final UserModel user;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                user.uId == Helper.currentUser!.uId
                    ? Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: const CustomGetBackButton(),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const CustomGetBackButton(),
                            CustomCircleIconButton(
                              onPressed: () {
                                context.navigateTo(
                                  routeName: Routes.chatDetailsRoute,
                                  arguments: user,
                                );
                              },
                              icon: Image.asset(AppAssets.iconsMessage),
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 77.h),
                UserProfileContent(user: user),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
