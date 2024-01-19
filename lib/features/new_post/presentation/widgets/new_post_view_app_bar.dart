import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/helpers/auth_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';
import 'package:social_app/features/posts/domain/entities/create_post_params.dart';
import 'package:social_app/features/posts/presentation/cubits/posts/posts_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class NewPostViewAppBar extends StatelessWidget {
  const NewPostViewAppBar({
    super.key,
    required this.cubit,
    required this.postText,
  });

  final PostsCubit cubit;
  final String postText;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: GetBackArrow(
        onPressed: () {
          BlocProvider.of<UserCubit>(context)
              .getUserPosts(uId: Helper.uId!)
              .then((value) {
            context.back();
          });
        },
      ),
      title: Text('CreatePost', style: AppTextStyles.textStyle23Bold),
      centerTitle: false,
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey; // Set disabled color
                }
                return AppColors.primaryColor; // Set enabled color
              },
            ),
            textStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppTextStyles.textStyle16;
                }
                return AppTextStyles.textStyle16SemiBold;
              },
            ),
          ),
          onPressed: cubit.postImage == null && postText.isEmpty
              ? null
              : () => _createNewPost(context),
          child: const Text('POST'),
        ),
      ],
    );
  }

  void _createNewPost(BuildContext context) {
    if (cubit.postImage == null && postText.isNotEmpty) {
      AuthHelper.keyboardUnfocus(context);
      cubit.createPost(
        createPostParams: CreatePostParams(
          date: Helper.getDate(),
          time: DateFormat.jm().format(DateTime.now()),
          text: postText,
        ),
        context: context,
      );
    } else if (cubit.postImage != null) {
      AuthHelper.keyboardUnfocus(context);
      cubit.uploadPostImage(
        createPostParams: CreatePostParams(
          date: Helper.getDate(),
          time: DateFormat.jm().format(DateTime.now()),
          text: postText,
        ),
        context: context,
      );
    }
  }
}
