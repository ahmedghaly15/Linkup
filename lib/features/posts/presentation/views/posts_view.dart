import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/core/widgets/custom_toast.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/features/posts/presentation/widgets/empty_post_view.dart';
import 'package:social_app/features/posts/presentation/widgets/posts.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: AppConstants.physics,
        slivers: [
          SliverAppBar(
            leading: Image.asset(AppAssets.AppIcon),
            title: Text(
              'Explore',
              style: AppTextStyles.textStyle20Bold,
            ),
            centerTitle: true,
          ),
          BlocConsumer<PostsCubit, PostsState>(
            listener: (context, state) => _controlFeedsState(state),
            builder: (context, state) {
              final PostsCubit cubit = BlocProvider.of<PostsCubit>(context);

              if (state is GetPostsLoading) {
                return const SliverToBoxAdapter(
                  child: BodyLoadingIndicator(),
                );
              } else if (state is GetPostsError) {
                return SliverToBoxAdapter(
                  child: CustomErrorWidget(
                    onPressed: () => cubit.getPosts(),
                    error: state.error,
                  ),
                );
              } else {
                return cubit.posts.isNotEmpty
                    ? Posts(posts: cubit.posts)
                    : const EmptyPostView();
              }
            },
          )
        ],
      ),
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
