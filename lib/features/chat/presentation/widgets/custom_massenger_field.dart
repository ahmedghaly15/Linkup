import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/global/app_colors.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/models/user_model.dart';
import '../../../../layout/cubit/cubit.dart';
import '../../../../shared/constants.dart';

class CustomMassengerField extends StatelessWidget {
  const CustomMassengerField({
    Key? key,
    required this.messageText,
    required this.messageController,
    required this.cubit,
    required this.userModel,
    this.messageImage,
  }) : super(key: key);

  final String messageText;
  final TextEditingController messageController;
  final SocialAppCubit cubit;
  final UserModel userModel;
  final File? messageImage;

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
                IconButton(
                  onPressed: () {
                    cubit.getMessageImage(
                      source: ImageSource.camera,
                    );
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.primaryColor,
                    size: 25,
                  ),
                ),
                // ============== Pick Image From Gallery Button ==============
                IconButton(
                  onPressed: () {
                    cubit.getMessageImage(
                      source: ImageSource.gallery,
                    );
                  },
                  icon: const Icon(
                    Icons.image_rounded,
                    color: AppColors.primaryColor,
                    size: 25,
                  ),
                ),
                // ============== Type A New Message TextField ==============
                Expanded(
                  child: SizedBox(
                    height: 50,
                    // width: 50,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: messageController,
                            enableSuggestions: true,
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: null,
                            cursorColor:
                                Get.isDarkMode ? Colors.white60 : Colors.black,
                            keyboardType: TextInputType.multiline,
                            style: AppStyles.bodySmall.copyWith(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              letterSpacing: 0.8,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              suffixIconColor: AppColors.primaryColor,
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 10),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              cubit.onChangeText(value, messageText);
                            },
                          ),
                          if (messageImage != null)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(messageImage!),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () =>
                                          cubit.removeMessageImage(),
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
                ),
              ],
            ),
          ),
        ),
        // ============== Send New Message Button ==============
        IconButton(
          onPressed: (messageText.trim().isEmpty && messageImage == null)
              ? null
              : () {
                  if (cubit.messageImage == null) {
                    cubit.sendMessage(
                      receiverId: userModel.uId!,
                      receiverName: userModel.name!,
                      date: getDate(),
                      time: TimeOfDay.now().format(context),
                      text: messageText.trim(),
                    );
                  }
                  if (cubit.messageImage != null) {
                    cubit.uploadMessageImage(
                      receiverId: userModel.uId!,
                      receiverName: userModel.name!,
                      date: getDate(),
                      time: TimeOfDay.now().format(context),
                      text: messageText.trim(),
                    );
                  }
                  messageController.clear();
                  cubit.removeMessageImage();
                },
          icon: const Icon(Icons.send_outlined),
          disabledColor: Colors.grey,
          iconSize: 30,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
