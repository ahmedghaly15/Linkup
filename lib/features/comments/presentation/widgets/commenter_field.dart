import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
import 'package:social_app/features/comments/domain/entities/type_new_comment_params.dart';
import 'package:social_app/features/comments/presentation/cubit/comments_cubit.dart';
import 'package:social_app/core/widgets/get_image_icon_button.dart';

class CommenterField extends StatefulWidget {
  const CommenterField({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<CommenterField> createState() => _CommenterFieldState();
}

class _CommenterFieldState extends State<CommenterField> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String commentText = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: BlocBuilder<ThemesCubit, ThemeData>(
            builder: (context, state) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
                color: Helper.isDark(state)
                    ? AppColors.darkGreyClr
                    : AppColors.scaffoldBackgroundClr,
                child: Row(
                  children: <Widget>[
                    GetImageIconButton(
                      onPressed: () {
                        BlocProvider.of<CommentsCubit>(context).getCommentImage(
                          source: ImageSource.camera,
                        );
                      },
                      icon: Icons.camera_alt_rounded,
                    ),
                    GetImageIconButton(
                      onPressed: () {
                        BlocProvider.of<CommentsCubit>(context).getCommentImage(
                          source: ImageSource.gallery,
                        );
                      },
                      icon: Icons.image_rounded,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: BlocBuilder<CommentsCubit, CommentsState>(
                            builder: (context, state) {
                          final CommentsCubit cubit =
                              BlocProvider.of<CommentsCubit>(context);

                          return Column(
                            children: <Widget>[
                              CustomTextFormField(
                                hasPrefixIcon: false,
                                controller: _commentController,
                                enableSuggestions: true,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                maxLines: null,
                                hintText: 'Write a comment...',
                                contentPadding: EdgeInsets.only(
                                  left: 5.w,
                                  right: 16.w,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: false,
                                keyboardType: TextInputType.multiline,
                                onChanged: (String value) {
                                  setState(() {
                                    commentText = value;
                                  });
                                },
                              ),
                              if (cubit.commentImage != null) ...[
                                SizedBox(height: 8.h),
                                Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: <Widget>[
                                    Container(
                                      height: 120.h,
                                      margin: EdgeInsets.only(
                                        right: 8.w,
                                        bottom: 8.h,
                                      ),
                                      width: double.infinity,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.r),
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(cubit.commentImage!),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10.h,
                                      right: 16.w,
                                      child: CircleAvatar(
                                        radius: 15.r,
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () =>
                                              cubit.removeCommentImage(),
                                          icon: Icon(
                                            Icons.close,
                                            color: AppColors.primaryColor,
                                            size: 20.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        TextButton(
          onPressed: (commentText.isEmpty &&
                  BlocProvider.of<CommentsCubit>(context).commentImage == null)
              ? null
              : () {
                  _typeNewComment(context);
                },
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
          child: const Text("Comment"),
        ),
      ],
    );
  }

  void _typeNewComment(BuildContext context) {
    if (BlocProvider.of<CommentsCubit>(context).commentImage == null) {
      BlocProvider.of<CommentsCubit>(context).typeNewComment(
        params: TypeNewCommentParams(
          postId: widget.postId,
          time: TimeOfDay.now().format(context),
          date: Helper.getDate(),
          commentText: commentText.trim(),
        ),
        context: context,
      );
    }

    if (BlocProvider.of<CommentsCubit>(context).commentImage != null) {
      BlocProvider.of<CommentsCubit>(context).uploadCommentImage(
        params: TypeNewCommentParams(
          postId: widget.postId,
          time: TimeOfDay.now().format(context),
          date: Helper.getDate(),
          commentText: commentText.trim(),
        ),
        context: context,
      );
    }
    setState(() {
      commentText = '';
    });
    _commentController.clear();
    BlocProvider.of<CommentsCubit>(context).removeCommentImage();
  }
}
