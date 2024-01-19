import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/features/posts/presentation/cubits/get_posts/get_posts_cubit.dart';
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
          BlocBuilder<GetPostsCubit, GetPostsState>(
            builder: (context, state) {
              final GetPostsCubit cubit =
                  BlocProvider.of<GetPostsCubit>(context);

              if (state is GetPostsSuccess) {
                return cubit.posts.isNotEmpty
                    ? Posts(posts: cubit.posts)
                    : const SliverToBoxAdapter(child: EmptyPostView());
              } else if (state is GetPostsError) {
                return SliverToBoxAdapter(
                  child: CustomErrorWidget(
                    onPressed: () => cubit.getPosts(),
                    error: state.error,
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: BodyLoadingIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
