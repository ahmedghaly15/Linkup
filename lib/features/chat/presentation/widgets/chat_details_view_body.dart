import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/features/chat/presentation/cubits/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_message_bubble.dart';
import 'package:social_app/features/chat/presentation/widgets/custom_messenger_field.dart';

class ChatDetailsViewBody extends StatelessWidget {
  const ChatDetailsViewBody({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final ChatCubit cubit = BlocProvider.of<ChatCubit>(context);

        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                Helper.isDark(context)
                    ? AppAssets.imagesChatDarkBackground
                    : AppAssets.imagesChatLightBackground,
              ),
            ),
          ),
          child: cubit.messages.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          physics: AppConstants.physics,
                          padding: EdgeInsets.zero,
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
                        ),
                      ),
                      CustomMessengerField(
                        cubit: cubit,
                        user: user,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 8.w,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      CustomMessengerField(
                        cubit: cubit,
                        user: user,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
