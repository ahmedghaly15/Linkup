import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/features/chat/presentation/widgets/chats_sliver_app_bar.dart';
import 'package:social_app/features/chat/presentation/widgets/empty_chats_view.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import '/features/chat/presentation/widgets/chat_item.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const ChatsSliverAppBar(),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              final UserCubit cubit = BlocProvider.of<UserCubit>(context);

              if (state is GetAllUsersLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: BodyLoadingIndicator(),
                  ),
                );
              } else if (state is GetAllUserError) {
                return SliverFillRemaining(
                  child: CustomErrorWidget(
                    onPressed: () => cubit.getAllUsers(),
                    error: state.error,
                  ),
                );
              } else {
                return cubit.users.isNotEmpty
                    ? SliverPadding(
                        padding: EdgeInsets.only(
                          bottom: 35.h,
                          left: 10.w,
                          right: 10.w,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ChatItem(
                                user: cubit.isSearching
                                    ? cubit.searchList[index]
                                    : cubit.users[index],
                              );
                            },
                            childCount: cubit.isSearching
                                ? cubit.searchList.length
                                : cubit.users.length,
                          ),
                        ),
                      )
                    : const EmptyChatsView();
              }
            },
          )
        ],
      ),
    );
  }
}
