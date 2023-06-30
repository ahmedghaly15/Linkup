import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_massenger_field.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_message_bubble.dart';
import 'package:social_app/layout/cubit/cubit.dart';

import '../../../../core/global/app_styles.dart';

class ChatDetailsViewBody extends StatelessWidget {
  const ChatDetailsViewBody({
    Key? key,
    required this.cubit,
    required this.userModel,
    required this.messageController,
  }) : super(key: key);

  final SocialAppCubit cubit;
  final UserModel userModel;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return cubit.messages.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.messages.length,
                    itemBuilder: (context, index) {
                      var message = cubit.messages[index];
                      return CustomMessageBubble(
                        messageModel: message,
                        isMe:
                            cubit.model!.uId == message.senderId ? true : false,
                      );
                      // return buildReceiverMessage();
                    },
                  ),
                ),
                CustomMassengerField(
                  cubit: cubit,
                  userModel: userModel,
                  messageController: messageController,
                  messageText: messageController.text,
                  messageImage: cubit.messageImage,
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "Say Hello \u{1F44B}",
                      style: AppStyles.headingLarge.copyWith(
                        fontSize: 30,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                CustomMassengerField(
                  cubit: cubit,
                  userModel: userModel,
                  messageController: messageController,
                  messageText: messageController.text,
                  messageImage: cubit.messageImage,
                ),
              ],
            ),
          );
  }
}
