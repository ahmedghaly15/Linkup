import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';

class PostImage extends StatelessWidget {
  const PostImage({
    super.key,
    required this.cubit,
  });

  final PostsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        Container(
          height: MediaQuery.sizeOf(context).height * 0.35,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: FileImage(cubit.postImage!),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0.h),
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () => cubit.removePostImage(),
              icon: Icon(
                Icons.close,
                color: AppColors.primaryColor,
                size: 25.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
