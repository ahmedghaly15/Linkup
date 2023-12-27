import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/post_information.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';

class TopPostItemSection extends StatelessWidget {
  const TopPostItemSection({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(child: PostInformation(post: post)),
        post.uId == Helper.currentUser!.uId
            ? IconButton(
                onPressed: () {
                  BlocProvider.of<PostsCubit>(context)
                      .deletePost(postId: post.postId!);
                },
                icon: Icon(
                  Icons.delete,
                  size: 25.w,
                  color: Colors.red,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
