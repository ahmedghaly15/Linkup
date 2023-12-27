import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/user_cover_image.dart';
import 'package:social_app/core/widgets/user_profile_image.dart';
import 'package:social_app/service_locator.dart';

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
                value: 'signOut',
                child: Text(
                  'Sign Out',
                  style: AppTextStyles.textStyle16SemiBold,
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'signOut') {
                await getIt
                    .get<CacheHelper>()
                    .removeData(key: AppStrings.uId)
                    .then((value) async {
                  getIt.get<FirebaseAuth>().signOut().then((value) {
                    context.navigateAndReplacement(
                        newRoute: Routes.signInRoute);
                  });
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
