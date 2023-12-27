import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/features/chat/presentation/widgets/chats_sliver_app_bar.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import '/features/chat/presentation/widgets/chat_item.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final UserCubit linkupCubit = BlocProvider.of<UserCubit>(context);

        return SafeArea(
          child: CustomScrollView(
            slivers: [
              const ChatsSliverAppBar(),
              if (state is GetAllUserSuccess)
                state.users.isNotEmpty
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
                                user: linkupCubit.isSearching
                                    ? linkupCubit.searchList[index]
                                    : state.users[index],
                              );
                            },
                            childCount: linkupCubit.isSearching
                                ? linkupCubit.searchList.length
                                : state.users.length,
                          ),
                        ),
                      )
                    : SliverFillRemaining(child: Container()),
              if (state is GetAllUserError)
                SliverFillRemaining(
                  child: CustomErrorWidget(
                    onPressed: () => linkupCubit.getAllUsers(),
                    error: state.error,
                  ),
                ),
              if (state is GetAllUsersLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: BodyLoadingIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
