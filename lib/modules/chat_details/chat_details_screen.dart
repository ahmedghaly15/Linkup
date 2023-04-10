import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/styles/colors.dart';

import '../../models/message_model.dart';
import '../../models/user_model.dart';

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
              appBar: AppBar(
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
                    const SizedBox(width: 5),
                    Text(
                      userModel.name!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                leading: IconButton(
                  onPressed: () => navigateBack(context),
                  icon: const Icon(Icons.arrow_back_ios),
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
                          const Expanded(
                            child: Center(
                              child: Text(
                                "Say Hello \u{1F44B}",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
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

  // Widget buildReceiverMessage({required MessageModel messageModel }) => Align(
  //       alignment: AlignmentDirectional.centerStart,
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 10,
  //           vertical: 5,
  //         ),
  //         decoration: BoxDecoration(
  //           color: Colors.grey[300],
  //           borderRadius: const BorderRadiusDirectional.only(
  //             bottomEnd: Radius.circular(10),
  //             topEnd: Radius.circular(10),
  //             topStart: Radius.circular(10),
  //           ),
  //         ),
  //         child: const Text("Hello World"),
  //       ),
  //     );

  Widget buildMessageBubble({
    required MessageModel messageModel,
    required bool isMe,
    required BuildContext context,
  }) =>
      Container(
        alignment: isMe
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ),
          child: Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 5,
            ),
            color: isMe ? defaultColor.withOpacity(0.55) : Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: isMe
                    ? const Radius.circular(10.0)
                    : const Radius.circular(0.0),
                bottomEnd: !isMe
                    ? const Radius.circular(10.0)
                    : const Radius.circular(0.0),
                topStart: const Radius.circular(10.0),
                topEnd: const Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (messageModel.messageText != null)
                    Text(
                      messageModel.messageText!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        letterSpacing: 0.5,
                        color: Colors.black,
                      ),
                      maxLines: null,
                    ),
                  if (messageModel.messageText != null)
                    const SizedBox(height: 5),
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${messageModel.date}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Text(
                        "${messageModel.time}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
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
    // final GlobalKey<FormState> formKey = GlobalKey();

    return Row(
      children: <Widget>[
        Flexible(
          child: Card(
            color: Colors.grey[200],
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
                            cursorColor: Colors.grey,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              // hintStyle: bodyStyle3,
                              suffixIconColor: defaultColor,
                              contentPadding:
                                  EdgeInsets.only(left: 5, right: 10),
                              border: InputBorder.none,
                            ),

                            onChanged: (value) {
                              cubit.onChangeText(value, messageText);
                              // cubit.onChangeCommentText(value, commentText);
                              // cubit.changeKey(UniqueKey());
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty)
                            //     return "Can't send a blank comment";
                            //   return null;
                            // },
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
                  // commentText = '';
                  // commentController.clear();
                  // autoFocus = false;
                  // print(autoFocus);
                  print("before Clear()");
                  // commentController = TextEditingController();
                  messageController.clear();
                  print("After Clear()");
                  // formKey.currentState!.reset();
                  // cubit.resetCommentText(commentText);
                  cubit.removeMessageImage();
                  // FocusScope.of(context).unfocus();
                  // formKey.currentState!.reset();
                },

          // if (formKey.currentState!.validate()) {

          // }

          icon: const Icon(Icons.send_outlined),
          disabledColor: Colors.grey,
          iconSize: 30,
          color: defaultColor,
        ),
      ],
    );
  }
}
