import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
import 'package:social_app/core/widgets/custom_toast.dart';
import 'package:social_app/features/feeds/presentation/cubits/feeds_cubit.dart';
import 'package:social_app/features/new_post/presentation/widgets/add_photos_and_tags_buttons.dart';
import 'package:social_app/features/new_post/presentation/widgets/new_post_view_app_bar.dart';
import 'package:social_app/features/new_post/presentation/widgets/post_image.dart';
import 'package:social_app/features/new_post/presentation/widgets/user_name_and_image.dart';

class NewPostViewBody extends StatefulWidget {
  const NewPostViewBody({super.key});

  @override
  State<NewPostViewBody> createState() => _NewPostViewBodyState();
}

class _NewPostViewBodyState extends State<NewPostViewBody> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedsCubit, FeedsState>(
      listener: (context, state) => _controlFeedsState(state, context),
      builder: (context, state) {
        final FeedsCubit cubit = BlocProvider.of<FeedsCubit>(context);

        return SafeArea(
          child: CustomScrollView(
            slivers: [
              NewPostViewAppBar(
                cubit: cubit,
                textController: _textController,
              ),
              SliverPadding(
                padding: AppConstants.horizontalPadding,
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
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          hintText:
                              "What's in your mind, ${Helper.currentUser!.name!.split(' ')[0]}",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      if (cubit.postImage != null) PostImage(cubit: cubit),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: AppConstants.horizontalPadding,
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.h),
                      const Spacer(),
                      AddPhotosAndTagsButtons(cubit: cubit),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _controlFeedsState(FeedsState state, BuildContext context) {
    if (state is CreatePostSuccess || state is UploadPostImageSuccess) {
      _textController.clear();
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
