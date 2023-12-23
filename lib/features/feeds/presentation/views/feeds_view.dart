import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/body_loading_indicator.dart';
import 'package:social_app/core/widgets/custom_error_widget.dart';
import 'package:social_app/features/feeds/presentation/cubits/feeds_cubit.dart';
import 'package:social_app/features/feeds/presentation/widgets/post_item.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        final FeedsCubit cubit = BlocProvider.of<FeedsCubit>(context);

        if (state is GetPostsSuccess) {
          return cubit.posts.isNotEmpty
              ? SafeArea(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                    physics: AppConstants.physics,
                    itemBuilder: (context, index) => PostItem(
                      post: cubit.posts[index],
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 24.h),
                    itemCount: cubit.posts.length,
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

        // return ConditionalBuilder(
        //   condition: AppCubit.getObject(context).posts.isNotEmpty &&
        //       Helper.currentUser != null,
        //   builder: (context) => SingleChildScrollView(
        //     physics: AppConstants.physics,
        //     child: Column(
        //       children: <Widget>[
        //         ListView.separated(
        //           shrinkWrap: true,
        //           physics: const NeverScrollableScrollPhysics(),
        //           itemBuilder: (context, index) => PostItem(
        //             context: context,
        //             postModel: AppCubit.getObject(context).posts[index],
        //           ),
        //           separatorBuilder: (context, index) => SizedBox(
        //             height: SizeConfig.screenHeight! * 0.005,
        //           ),
        //           itemCount: AppCubit.getObject(context).posts.length,
        //         ),
        //         SizedBox(
        //           height: SizeConfig.screenHeight! * 0.008,
        //         ),
        //       ],
        //     ),
        //   ),
        //   fallback: (context) => const Column(
        //     children: <Widget>[],
        //   ),
        // );
      },
    );
  }
}
