import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/global/app_styles.dart';
import '/core/models/message_model.dart';
import '/core/utils/size_config.dart';

class CustomMessageBubble extends StatelessWidget {
  const CustomMessageBubble({
    Key? key,
    required this.messageModel,
    required this.isMe,
  }) : super(key: key);

  final MessageModel messageModel;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: isMe
          ? ChatBubbleClipper4(type: BubbleType.sendBubble)
          : ChatBubbleClipper4(type: BubbleType.receiverBubble),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      backGroundColor: isMe
          ? AppColors.primaryColor.withOpacity(0.55)
          : (Get.isDarkMode
              ? AppColors.darkGreyClr.withOpacity(0.9)
              : const Color(0xffE7E7ED)),
      margin: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 5,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.65,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (messageModel.messageText != null)
                Text(
                  messageModel.messageText!,
                  style: AppStyles.bodySmall.copyWith(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    letterSpacing: 0.8,
                  ),
                  maxLines: null,
                ),
              if (messageModel.messageText != null)
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.008,
                ),
              if (messageModel.messageImage!['image'] != null)
                Container(
                  width: double.infinity,
                  height: 150,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        messageModel.messageImage!['image'],
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.005,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "${messageModel.date}",
                    style: AppStyles.caption.copyWith(
                      color: Get.isDarkMode ? Colors.white54 : Colors.black38,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode ? Colors.grey : Colors.black45,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text(
                    "${messageModel.time}",
                    style: AppStyles.caption.copyWith(
                      color: Get.isDarkMode ? Colors.white54 : Colors.black38,
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
