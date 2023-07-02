import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/global/app_colors.dart';
import '/core/models/post_model.dart';
import '/features/feeds/presentation/widgets/post_item_content.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.context,
    required this.postModel,
  }) : super(key: key);

  final BuildContext context;
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      color:
          Get.isDarkMode ? AppColors.darkGreyClr.withOpacity(0) : Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 10,
        ),
        child: PostItemContent(model: postModel),
      ),
    );
  }
}
