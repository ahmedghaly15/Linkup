import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/comments/presentation/cubit/comments_cubit.dart';

class GetCommentImageIconButton extends StatelessWidget {
  const GetCommentImageIconButton({
    Key? key,
    required this.source,
    required this.icon,
  }) : super(key: key);

  final ImageSource source;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<CommentsCubit>(context).getCommentImage(
          source: source,
        );
      },
      icon: Icon(
        icon,
        color: AppColors.primaryColor,
        size: 25.w,
      ),
    );
  }
}
