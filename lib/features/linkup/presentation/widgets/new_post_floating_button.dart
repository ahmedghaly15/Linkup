import 'package:flutter/material.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_navigator.dart';

class NewPostFloatingButton extends StatelessWidget {
  const NewPostFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        heroTag: "Floating New Post Button",
        onPressed: () => context.navigateTo(
          routeName: Routes.newPostRoute,
        ),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.post_add,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
