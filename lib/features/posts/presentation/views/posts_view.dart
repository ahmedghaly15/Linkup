import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/features/posts/presentation/widgets/empty_post_view.dart';
import 'package:social_app/features/posts/presentation/widgets/posts.dart';
import 'package:social_app/features/posts/presentation/widgets/shimmer_posts.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

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
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                final UserCubit cubit = BlocProvider.of<UserCubit>(context);

                if (state is GetPostsLoading) {
                  return const ShimmerPosts();
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
                      : const SliverToBoxAdapter(child: EmptyPostView());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
