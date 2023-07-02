import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/models/comment_model.dart';
import '/features/feeds/presentation/widgets/comment_item_content.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, required this.commentModel}) : super(key: key);

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(commentModel.image!),
          radius: 20,
        ),
        Flexible(
          child: ChatBubble(
            clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
            margin: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 5,
            ),
            backGroundColor: Get.isDarkMode
                ? AppColors.darkGreyClr.withOpacity(0.9)
                : const Color(0xffE7E7ED),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10,
                ),
                child: CommentItemContent(commentModel: commentModel),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
