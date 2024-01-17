import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/utils/app_navigator.dart';

class NewPostFloatingButton extends StatelessWidget {
  const NewPostFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "Floating New Post Button",
      onPressed: () => context.navigateTo(
        routeName: Routes.newPostRoute,
      ),
      backgroundColor: AppColors.primaryColor,
      child: Icon(
        Icons.post_add,
        size: 25.w,
        color: Colors.white,
      ),
    );
  }
}
