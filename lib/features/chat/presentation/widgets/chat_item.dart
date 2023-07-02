import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_styles.dart';
import '/core/global/app_colors.dart';
import '/core/global/app_navigator.dart';
import '/core/models/user_model.dart';
import '/features/chat/presentation/views/chat_details_view.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.model}) : super(key: key);

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppNavigator.navigateTo(
        screen: ChatDetailsView(userModel: model),
      ),
      child: Card(
        color: Get.isDarkMode
            ? AppColors.darkHeaderClr.withOpacity(0)
            : Colors.white,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
          vertical: 4,
        ),
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
          child: ListTile(
            // ============== User Profile Picture ==============
            leading: Hero(
              tag: model.uId!,
              child: CircleAvatar(
                backgroundImage: NetworkImage(model.image!),
                radius: 28,
              ),
            ),
            // ============== Username ==============
            title: Text(
              model.name!,
              style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            // ============== User's Bio ==============
            subtitle: Text(
              model.bio!,
              style: AppStyles.caption.copyWith(fontSize: 14),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
