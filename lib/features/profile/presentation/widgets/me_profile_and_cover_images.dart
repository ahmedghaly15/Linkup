import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/user_cover_image.dart';
import 'package:social_app/core/widgets/user_profile_image.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class MeProfileAndCoverImages extends StatelessWidget {
  const MeProfileAndCoverImages({
    Key? key,
    required this.me,
  }) : super(key: key);

  final UserModel me;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        UserCoverImage(cover: me.cover!),
        Positioned(
          bottom: 20.h,
          child: UserProfileImage(image: me.image!),
        ),
        Positioned(
          top: 25.h,
          right: 16.w,
          child: PopupMenuButton(
            icon: Container(
              height: 30.h,
              width: 30.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: const Icon(Icons.more_vert),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'editProfile',
                child: Text(
                  'Edit Profile',
                  style: AppTextStyles.textStyle16SemiBold,
                ),
              ),
              PopupMenuItem(
                value: 'signOut',
                child: Text(
                  'Sign Out',
                  style: AppTextStyles.textStyle16SemiBold,
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'editProfile') {
                context.navigateTo(routeName: Routes.editProfileRoute);
              }

              if (value == 'signOut') {
                BlocProvider.of<UserCubit>(context).signOut();
              }
            },
          ),
        ),
      ],
    );
  }
}
