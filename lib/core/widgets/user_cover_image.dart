import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/widgets/cached_image_error_icon.dart';

class UserCoverImage extends StatelessWidget {
  const UserCoverImage({
    super.key,
    required this.cover,
  });

  final String cover;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.r),
            topRight: Radius.circular(5.r),
          ),
        ),
        child: CachedNetworkImage(
          height: screenHeight * 0.25,
          width: double.infinity,
          errorWidget: (context, error, _) => const CachedImageErrorIcon(),
          imageUrl: cover,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
