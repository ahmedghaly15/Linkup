import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/linkup/presentation/views/manager/app_cubit.dart';

import '../../../../core/utils/app_colors.dart';

class GetCommentImageIconButton extends StatelessWidget {
  const GetCommentImageIconButton({
    Key? key,
    required this.source,
    required this.cubit,
    required this.icon,
  }) : super(key: key);

  final ImageSource source;
  final AppCubit cubit;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        cubit.getCommentImage(
          source: source,
        );
      },
      icon: Icon(
        icon,
        color: AppColors.primaryColor,
        size: 25,
      ),
    );
  }
}
