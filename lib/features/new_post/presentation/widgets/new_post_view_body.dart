import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
import 'package:social_app/core/widgets/custom_toast.dart';
import 'package:social_app/features/new_post/presentation/widgets/add_photos_and_tags_buttons.dart';
import 'package:social_app/features/new_post/presentation/widgets/new_post_view_app_bar.dart';
import 'package:social_app/features/new_post/presentation/widgets/post_image.dart';
import 'package:social_app/features/new_post/presentation/widgets/user_name_and_image.dart';
import 'package:social_app/features/posts/presentation/cubits/posts/posts_cubit.dart';

class NewPostViewBody extends StatefulWidget {
  const NewPostViewBody({super.key});

  @override
  State<NewPostViewBody> createState() => _NewPostViewBodyState();
}

class _NewPostViewBodyState extends State<NewPostViewBody> {
  final TextEditingController _textController = TextEditingController();

  String postText = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) => _controlFeedsState(state, context),
      builder: (context, state) {
        final PostsCubit cubit = BlocProvider.of<PostsCubit>(context);

        return CustomFillingContainer(
          child: CustomContentContainer(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: NewPostViewAppBar(
                    cubit: cubit,
                    postText: postText,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 32.h),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        if (state is CreatePostLoading ||
                            state is UploadPostImageLoading) ...[
                          const LinearProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(height: 15.h),
                        ],
                        const UserNameAndImage(),
                        SizedBox(height: 10.h),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: CustomTextFormField(
                            maxLines: null,
                            hasPrefixIcon: false,
                            controller: _textController,
                            enableSuggestions: true,
                            filled: false,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.multiline,
                            hintText:
                                "What's in your mind, ${Helper.currentUser!.name!.split(' ')[0]}",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (String value) {
                              setState(() {
                                postText = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15.h),
                        if (cubit.postImage != null) PostImage(cubit: cubit),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.h),
                      const Spacer(),
                      AddPhotosAndTagsButtons(cubit: cubit),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _controlFeedsState(PostsState state, BuildContext context) {
    if (state is CreatePostSuccess) {
      _textController.clear();
      setState(() {
        postText = '';
      });
    }

    if (state is CreatePostError) {
      CustomToast.showToast(
        text: state.error,
        state: CustomToastState.error,
      );
    }

    if (state is PostImagePickedError) {
      CustomToast.showToast(
        text: state.error,
        state: CustomToastState.error,
      );
    }

    if (state is UploadPostImageError) {
      CustomToast.showToast(
        text: state.error,
        state: CustomToastState.error,
      );
    }
  }
}
