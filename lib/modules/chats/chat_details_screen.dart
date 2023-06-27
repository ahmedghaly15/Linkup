import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/models/message_model.dart';
import '../../core/models/user_model.dart';
import '/layout/cubit/cubit.dart';
import '/layout/cubit/states.dart';

import '/shared/constants.dart';
import '/styles/thems.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  ChatDetailsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialAppCubit.getObject(context).getMessages(
          receiverId: userModel.uId!,
        );

        return BlocConsumer<SocialAppCubit, SocialAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SocialAppCubit cubit = SocialAppCubit.getObject(context);
            return Scaffold(
              backgroundColor: context.theme.colorScheme.background,
              appBar: AppBar(
                backgroundColor: context.theme.colorScheme.background,
                titleSpacing: 0.0,
                elevation: 1,
                title: Row(
                  children: <Widget>[
                    Hero(
                      tag: userModel.uId!,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userModel.image!),
                        radius: 20.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      userModel.name!,
                      style: bodyLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                leading: IconButton(
                  onPressed: () => navigateBack(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  systemNavigationBarColor:
                      Get.isDarkMode ? darkGreyClr : Colors.white,
                  statusBarColor: Get.isDarkMode ? darkGreyClr : Colors.white,
                  statusBarBrightness:
                      Get.isDarkMode ? Brightness.light : Brightness.dark,
                ),
              ),
              body: cubit.messages.isNotEmpty
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
                                return buildMessageBubble(
                                  messageModel: message,
                                  isMe: cubit.model!.uId == message.senderId
                                      ? true
                                      : false,
                                  context: context,
                                );
                                // return buildReceiverMessage();
                              },
                            ),
                          ),
                          buildMassengerField(
                            cubit: cubit,
                            context: context,
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
                                style: headingLarge.copyWith(
                                  fontSize: 30,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          buildMassengerField(
                            cubit: cubit,
                            context: context,
                            userModel: userModel,
                            messageController: messageController,
                            messageText: messageController.text,
                            messageImage: cubit.messageImage,
                          ),
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }

  Widget buildMessageBubble({
    required MessageModel messageModel,
    required bool isMe,
    required BuildContext context,
  }) =>
      ChatBubble(
        clipper: isMe
            ? ChatBubbleClipper4(type: BubbleType.sendBubble)
            : ChatBubbleClipper4(type: BubbleType.receiverBubble),
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        backGroundColor: isMe
            ? defaultColor.withOpacity(0.55)
            : (Get.isDarkMode
                ? darkGreyClr.withOpacity(0.9)
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
                    style: bodySmall.copyWith(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      letterSpacing: 0.8,
                    ),
                    maxLines: null,
                  ),
                if (messageModel.messageText != null) const SizedBox(height: 5),
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
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${messageModel.date}",
                      style: caption.copyWith(
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
                      style: caption.copyWith(
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

  Widget buildMassengerField({
    required String messageText,
    required TextEditingController messageController,
    required BuildContext context,
    required SocialAppCubit cubit,
    required UserModel userModel,
    File? messageImage,
  }) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Card(
            color:
                Get.isDarkMode ? darkGreyClr.withOpacity(0) : Colors.grey[200],
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
                    color: defaultColor,
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
                    color: defaultColor,
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
                            style: bodySmall.copyWith(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              letterSpacing: 0.8,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              suffixIconColor: defaultColor,
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
                                      image: FileImage(messageImage),
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
                                        color: defaultColor,
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
          color: defaultColor,
        ),
      ],
    );
  }
}
