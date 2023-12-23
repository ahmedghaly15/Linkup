import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/helpers/helper.dart';
import '../../../../linkup/presentation/views/manager/app_cubit.dart';
import '/core/models/user_model.dart';
import '/features/chat/presentation/widgets/custom_massenger_field.dart';
import '/features/chat/presentation/widgets/custom_message_bubble.dart';

class ChatDetailsViewBody extends StatelessWidget {
  const ChatDetailsViewBody({
    Key? key,
    required this.cubit,
    required this.userModel,
    required this.messageController,
  }) : super(key: key);

  final AppCubit cubit;
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
                        isMe: Helper.currentUser!.uId == message.senderId
                            ? true
                            : false,
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
                      style: AppTextStyles.textStyle50Bold.copyWith(
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
                ),
              ],
            ),
          );
  }
}
