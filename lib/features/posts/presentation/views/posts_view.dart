import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/core/widgets/custom_toast.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/features/posts/presentation/widgets/post_item.dart';

class PostsView extends StatelessWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) => _controlFeedsState(state),
      builder: (context, state) {
        final PostsCubit cubit = BlocProvider.of<PostsCubit>(context);

        if (state is GetPostsSuccess) {
          return state.posts.isNotEmpty
              ? SafeArea(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                    physics: AppConstants.physics,
                    itemBuilder: (context, index) => PostItem(
                      key: UniqueKey(),
                      post: state.posts[index],
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 24.h),
                    itemCount: state.posts.length,
                  ),
                )
              : Container();
        } else if (state is GetPostsError) {
          return CustomErrorWidget(
            onPressed: () => cubit.getPosts(),
            error: state.error,
          );
        } else {
          return const BodyLoadingIndicator();
        }
      },
    );
  }

  void _controlFeedsState(PostsState state) {
    if (state is DeletePostSuccess) {
      CustomToast.showToast(
        text: 'Post deleted successfully',
        state: CustomToastState.success,
      );
    }
  }
}
