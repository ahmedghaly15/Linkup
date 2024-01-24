import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/features/chat/presentation/widgets/chats_sliver_app_bar.dart';
import 'package:social_app/features/chat/presentation/widgets/empty_chats_view.dart';
import 'package:social_app/features/chat/presentation/widgets/shimmer_chats.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_followers/get_followers_cubit.dart';
import '/features/chat/presentation/widgets/chat_item.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFillingContainer(
      child: CustomContentContainer(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(bottom: 16.h),
              sliver: const ChatsSliverAppBar(),
            ),
            BlocBuilder<GetFollowersCubit, GetFollowersState>(
              builder: (context, state) {
                final GetFollowersCubit cubit =
                    BlocProvider.of<GetFollowersCubit>(context);

                if (state is GetFollowersSuccess) {
                  return SliverFillRemaining(
                      child: CustomErrorWidget(onPressed: () {}, error: 'dfd'));

                  // return state.followers.isNotEmpty
                  //     ? SliverPadding(
                  //         padding: EdgeInsets.only(
                  //           bottom: 35.h,
                  //           left: 10.w,
                  //           right: 10.w,
                  //         ),
                  //         sliver: SliverList(
                  //           delegate: SliverChildBuilderDelegate(
                  //             (context, index) {
                  //               return ChatItem(
                  //                 user: cubit.isSearching
                  //                     ? cubit.searchList[index]
                  //                     : state.followers[index],
                  //               );
                  //             },
                  //             childCount: cubit.isSearching
                  //                 ? cubit.searchList.length
                  //                 : state.followers.length,
                  //           ),
                  //         ),
                  //       )
                  //     : const EmptyChatsView();
                } else if (state is GetFollowersError) {
                  return SliverFillRemaining(
                    child: CustomErrorWidget(
                      onPressed: () => cubit.getFollowers(),
                      error: state.error,
                    ),
                  );
                } else {
                  return const ShimmerChats();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
