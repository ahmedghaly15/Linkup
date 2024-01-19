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
        child: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
          final ChatCubit cubit = BlocProvider.of<ChatCubit>(context);

          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 60.h),
                child: CustomScrollView(
                  physics: AppConstants.physics,
                  slivers: [
                    CustomChatDetailsViewAppBar(user: user),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Divider(
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ),
                    ),
                    cubit.messages.isNotEmpty
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final reversedIndex =
                                    cubit.messages.length - 1 - index;

                                return Container(
                                  margin: EdgeInsets.only(bottom: 16.h),
                                  child: CustomMessageBubble(
                                    message: cubit.messages[reversedIndex],
                                    isMe: Helper.currentUser!.uId ==
                                            cubit.messages[reversedIndex]
                                                .senderId
                                        ? true
                                        : false,
                                  ),
                                );
                              },
                              childCount: cubit.messages.length,
                            ),
                          )
                        : const SliverFillRemaining(child: SizedBox()),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomMessengerField(cubit: cubit, user: user),
              ),
            ],
          );
        }),
      ),
    );
  }
}
