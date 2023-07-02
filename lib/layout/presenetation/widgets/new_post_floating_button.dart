import 'package:flutter/material.dart';

import '../../../core/global/app_colors.dart';
import '../../../core/global/app_navigator.dart';
import '../../../features/new_post/presentation/view/new_post_view.dart';

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
        onPressed: () => AppNavigator.navigateTo(
          screen: const NewPostView(),
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
