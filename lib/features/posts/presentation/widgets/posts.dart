import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/features/posts/presentation/widgets/post_item.dart';

class Posts extends StatelessWidget {
  const Posts({
    super.key,
    required this.posts,
  });

  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
            final PostsCubit cubit = BlocProvider.of<PostsCubit>(context);

            return StreamBuilder<bool>(
                stream: posts[index].postId != null
                    ? cubit.likedPostsByMe(postId: posts[index].postId!)
                    : const Stream<bool>.empty(),
                builder: (context, snapshot) {
                  bool isPostLikedByMe = snapshot.data ?? false;

                  return InkWell(
                    onDoubleTap: () {
                      isPostLikedByMe
                          ? cubit.unLikePost(postId: posts[index].postId!)
                          : cubit.likePost(postId: posts[index].postId!);
                    },
                    child: PostItem(post: posts[index]),
                  );
                });
          });
        },
        childCount: posts.length,
      ),
    );
  }
}
