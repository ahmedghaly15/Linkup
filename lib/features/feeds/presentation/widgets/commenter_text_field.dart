import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/global/app_styles.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';

class CommenterTextField extends StatelessWidget {
  const CommenterTextField({
    super.key,
    required this.commentController,
    required this.cubit,
    required this.commentText,
    required this.commentImage,
  });

  final TextEditingController commentController;
  final AppCubit cubit;
  final String commentText;
  final File? commentImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: commentController,
                autofocus: true,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                cursorColor: Get.isDarkMode ? Colors.white60 : Colors.black,
                style: AppStyles.bodySmall.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: 0.8,
                ),
                decoration: const InputDecoration(
                  hintText: 'Write a comment...',
                  suffixIconColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.only(left: 5, right: 10),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  cubit.onChangeText(value, commentText);
                },
              ),
              if (commentImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(commentImage!),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () => cubit.removeCommentImage(),
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
