import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';
import 'package:social_app/features/comments/domain/entities/comments_view_params.dart';
import 'package:social_app/features/comments/presentation/cubit/comments_cubit.dart';
import 'package:social_app/features/comments/presentation/widgets/comment_item.dart';
import 'package:social_app/features/comments/presentation/widgets/commenter_field.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({
    Key? key,
    required this.params,
  }) : super(key: key);

  final CommentsViewParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 60.h),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      "Comments",
                      style: AppTextStyles.textStyle23Bold,
                    ),
                    centerTitle: true,
                    leading: GetBackArrow(
                      onPressed: () {
                        BlocProvider.of<CommentsCubit>(context).clearComments();

                        context.getBack();
                      },
                    ),
                  ),
                  BlocBuilder<CommentsCubit, CommentsState>(
                      builder: (context, state) {
                    final cubit = BlocProvider.of<CommentsCubit>(context);
                    return cubit.comments.isNotEmpty
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return CommentItem(
                                  comment: cubit.comments[index],
                                );
                              },
                              childCount: cubit.comments.length,
                            ),
                          )
                        : SliverFillRemaining(child: Container());
                  }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CommenterField(postId: params.postId!),
            ),
          ],
        ),
      ),
    );
  }
}
