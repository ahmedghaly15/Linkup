import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:social_app/features/posts/presentation/cubits/posts/posts_cubit.dart';
import 'package:social_app/features/posts/presentation/widgets/person_who_liked.dart';

class PostLikesView extends StatelessWidget {
  const PostLikesView({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFillingContainer(
        child: CustomContentContainer(
          child: SafeArea(
            child: CustomScrollView(
              physics: AppConstants.physics,
              slivers: [
                const CustomSliverAppBar(title: 'People who liked'),
                BlocBuilder<PostsCubit, PostsState>(
                  builder: (context, state) {
                    final PostsCubit cubit =
                        BlocProvider.of<PostsCubit>(context);

                    cubit.peopleLikeThePost(postId: postId);

                    return cubit.peopleLikePost.isNotEmpty
                        ? SliverPadding(
                            padding: EdgeInsets.symmetric(vertical: 16.w),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 700),
                                    child: SlideAnimation(
                                      horizontalOffset: -150.w,
                                      child: PersonWhoLiked(
                                        like: cubit.peopleLikePost[index],
                                      ),
                                    ),
                                  );
                                },
                                childCount: cubit.peopleLikePost.length,
                              ),
                            ),
                          )
                        : const SliverFillRemaining(child: SizedBox());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
