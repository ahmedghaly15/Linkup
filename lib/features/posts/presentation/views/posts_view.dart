import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/features/posts/presentation/cubits/get_posts/get_posts_cubit.dart';
import 'package:social_app/features/posts/presentation/widgets/empty_post_view.dart';
import 'package:social_app/features/posts/presentation/widgets/posts.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFillingContainer(
      child: CustomContentContainer(
        backgroundColor: Colors.white,
        child: CustomScrollView(
          physics: AppConstants.physics,
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Image.asset(
                    AppAssets.AppIcon,
                    height: 48.h,
                    width: 48.h,
                  ),
                  const Spacer(),
                  Text(
                    'Explore',
                    style: AppTextStyles.textStyle20Bold,
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            BlocBuilder<GetPostsCubit, GetPostsState>(
              builder: (context, state) {
                final GetPostsCubit cubit =
                    BlocProvider.of<GetPostsCubit>(context);

                if (state is GetPostsSuccess) {
                  return state.posts.isNotEmpty
                      ? Posts(posts: state.posts)
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
      ),
    );
  }
}
