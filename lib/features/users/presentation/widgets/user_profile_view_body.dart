import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/widgets/custom_circle_icon_button.dart';
import 'package:social_app/core/widgets/custom_get_back_button.dart';
import 'package:social_app/core/widgets/user_profile_content.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/following_and_followers_cubit.dart';

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
                            StreamBuilder<bool>(
                                stream:
                                    BlocProvider.of<FollowingAndFollowersCubit>(
                                            context)
                                        .userIsInFollowers(uId: user.uId!),
                                builder: (context, snapshot) {
                                  bool isInFollowers = snapshot.data ?? false;

                                  return CustomCircleIconButton(
                                    onPressed: () => Helper.message(
                                      isInFollowers: isInFollowers,
                                      context: context,
                                      user: user,
                                    ),
                                    icon: Image.asset(AppAssets.iconsMessage),
                                  );
                                }),
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
