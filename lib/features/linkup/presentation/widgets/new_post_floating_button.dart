import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';

class NewPostFloatingButton extends StatelessWidget {
  const NewPostFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      width: 68.h,
      decoration: BoxDecoration(
        color: const Color(0xfff3e4e1),
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 10.h),
            blurRadius: 20.r,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () => context.navigateTo(
          routeName: Routes.newPostRoute,
        ),
        icon: Image.asset(AppAssets.iconsPlus),
      ),
    );
  }
}
