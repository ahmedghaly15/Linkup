import 'package:flutter/material.dart';

import '/core/models/post_model.dart';
import '/features/feeds/presentation/widgets/post_text_and_image.dart';
import 'custom_divider.dart';
import 'likes_and_comments.dart';
import 'top_post_item_section.dart';
import 'write_comment_input_field.dart';

class PostItemContent extends StatelessWidget {
  const PostItemContent({Key? key, required this.model}) : super(key: key);

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TopPostItemSection(model: model),
        const CustomDivider(),
        PostTextAndImage(model: model),
        LikesAndComments(model: model),
        const CustomDivider(),
        WriteCommentInputField(model: model),
      ],
    );
  }
}
