import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/features/posts/data/models/post_model.dart';

class PostTextAndImage extends StatelessWidget {
  const PostTextAndImage({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (post.text != null) ...[
          SizedBox(height: 10.h),
          Linkify(
            text: post.text!,
            style: AppTextStyles.textStyle16,
            onOpen: (link) async {
              if (_isEmail(link.text)) {
                await launchUrl(Uri.parse(link.url));
              } else {
                await launchUrl(
                  Uri.parse(link.url),
                  mode: LaunchMode.inAppBrowserView,
                );
              }
            },
          ),
        ],
        if (post.postImage != '' && post.text != '') SizedBox(height: 15.h),
        if (post.postImage != '')
          Container(
            height: 268.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(post.postImage!),
              ),
            ),
          ),
      ],
    );
  }

  bool _isEmail(String input) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(input);
  }
}
