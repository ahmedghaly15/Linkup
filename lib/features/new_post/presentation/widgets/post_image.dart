import 'package:flutter/material.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../layout/cubit/cubit.dart';

class PostImage extends StatelessWidget {
  const PostImage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final SocialAppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: FileImage(cubit.postImage!),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () => cubit.removePostImage(),
              icon: const Icon(
                Icons.close,
                color: AppColors.primaryColor,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
