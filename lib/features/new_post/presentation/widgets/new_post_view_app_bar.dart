import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';
import 'package:social_app/features/feeds/domain/entities/create_post_params.dart';
import 'package:social_app/features/feeds/presentation/cubits/feeds_cubit.dart';

class NewPostViewAppBar extends StatelessWidget {
  final FeedsCubit cubit;
  final TextEditingController textController;

  const NewPostViewAppBar({
    super.key,
    required this.cubit,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const GetBackArrow(),
      title: Text('CreatePost', style: AppTextStyles.textStyle23Bold),
      centerTitle: false,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (cubit.postImage == null && textController.text.isNotEmpty) {
              cubit.createPost(
                createPostParams: CreatePostParams(
                  date: Helper.getDate(),
                  time: DateFormat.jm().format(DateTime.now()),
                  text: textController.text,
                ),
              );
            } else if (cubit.postImage != null) {
              cubit.uploadPostImage(
                createPostParams: CreatePostParams(
                  date: Helper.getDate(),
                  time: DateFormat.jm().format(DateTime.now()),
                  text: textController.text,
                ),
              );
            }
          },
          child: const Text('POST'),
        ),
      ],
    );
  }
}
