import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/features/chat/presentation/cubits/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_chat_details_view_app_bar.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_message_bubble.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_messenger_field.dart';

class ChatDetailsViewBody extends StatelessWidget {
  const ChatDetailsViewBody({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return CustomFillingContainer(
      child: CustomContentContainer(
        horizontalPadding: 10,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 60.h),
              child: Column(
                children: <Widget>[
                  CustomChatDetailsViewAppBar(user: user),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Divider(
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: BlocProvider.of<ChatCubit>(context)
                          .getMessagesStream(user.uId!),
                      builder: (context, snapshot) {
                        final ChatCubit cubit =
                            BlocProvider.of<ChatCubit>(context);

                        return Expanded(
                          child: cubit.messages.isNotEmpty
                              ? ListView.separated(
                                  reverse: true,
                                  physics: AppConstants.physics,
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  shrinkWrap: true,
                                  itemCount: cubit.messages.length,
                                  itemBuilder: (context, index) {
                                    return CustomMessageBubble(
                                      message: cubit.messages[index],
                                      isMe: Helper.currentUser!.uId ==
                                              cubit.messages[index].senderId
                                          ? true
                                          : false,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 8.h),
                                )
                              : const SizedBox(),
                        );
                      }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomMessengerField(user: user),
            ),
          ],
        ),
      ),
    );
  }
}
