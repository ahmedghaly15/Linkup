import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/comments/data/models/comment_model.dart';
import 'package:social_app/features/comments/presentation/widgets/comment_item_content.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: comment.image!,
          imageBuilder: (_, image) {
            return CircleAvatar(
              backgroundImage: image,
              radius: 20.r,
              backgroundColor: AppColors.primaryColor,
            );
          },
        ),
        Flexible(
          child: BlocBuilder<ThemesCubit, ThemeData>(
            builder: (context, state) {
              return ChatBubble(
                clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                backGroundColor: state.brightness == Brightness.dark
                    ? AppColors.darkGreyClr.withOpacity(0.9)
                    : const Color(0xffE7E7ED),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 5.h,
                    ),
                    child: CommentItemContent(comment: comment),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
