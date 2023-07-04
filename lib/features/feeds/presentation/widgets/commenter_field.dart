import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '/core/global/app_colors.dart';
import '/features/feeds/presentation/widgets/commenter_text_button_sender.dart';
import '/features/feeds/presentation/widgets/get_comment_image_icon_button.dart';
import 'commenter_text_field.dart';

class CommenterField extends StatelessWidget {
  const CommenterField({
    Key? key,
    required this.commentText,
    required this.commentController,
    required this.context,
    required this.cubit,
    required this.postId,
    this.commentImage,
  }) : super(key: key);

  final String commentText;
  final TextEditingController commentController;
  final BuildContext context;
  final AppCubit cubit;
  final String postId;
  final File? commentImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Card(
            color: Get.isDarkMode
                ? AppColors.darkGreyClr.withOpacity(0)
                : Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: <Widget>[
                GetCommentImageIconButton(
                  source: ImageSource.camera,
                  cubit: cubit,
                  icon: Icons.camera_alt_rounded,
                ),
                GetCommentImageIconButton(
                  source: ImageSource.gallery,
                  cubit: cubit,
                  icon: Icons.image_rounded,
                ),

                // ============== Type A New Comment TextField ==============
                CommenterTextField(
                  commentController: commentController,
                  cubit: cubit,
                  commentText: commentText,
                ),
              ],
            ),
          ),
        ),

        // ============== Send New Message Button ==============
        CommenterTextButtonSender(
          commentText: commentText,
          commentController: commentController,
          cubit: cubit,
          postId: postId,
        ),
      ],
    );
  }
}
