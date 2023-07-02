import 'package:flutter/material.dart';

import '../../../../core/global/app_styles.dart';
import '/core/models/post_model.dart';

class PostTextAndImage extends StatelessWidget {
  const PostTextAndImage({Key? key, required this.model}) : super(key: key);

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          model.text!,
          style: AppStyles.bodySmall.copyWith(letterSpacing: 0.5),
        ),
        if (model.postImage != '')
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 15),
            child: Container(
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
            ),
          )
      ],
    );
  }
}
