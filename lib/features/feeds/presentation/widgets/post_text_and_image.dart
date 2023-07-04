import 'package:flutter/material.dart';

import '../../../../core/global/app_styles.dart';
import '/core/models/post_model.dart';

class PostTextAndImage extends StatelessWidget {
  const PostTextAndImage({Key? key, required this.model}) : super(key: key);

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (model.text != null) ...[
          const SizedBox(height: 15),
          Text(
            model.text!,
            style: AppStyles.bodySmall.copyWith(
              letterSpacing: 0.5,
              fontSize: 17,
            ),
          ),
        ],
        if (model.postImage != '' && model.text != '')
          const SizedBox(height: 15),
        if (model.postImage != '')
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  model.postImage!,
                ),
              ),
            ),
          )
      ],
    );
  }
}
