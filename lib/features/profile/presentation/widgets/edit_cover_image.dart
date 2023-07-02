import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/custom_bottom_sheet.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';

class EditCoverImage extends StatelessWidget {
  const EditCoverImage({
    Key? key,
    required this.coverImage,
    required this.userModel,
    required this.cubit,
  }) : super(key: key);

  final File? coverImage;
  final UserModel userModel;
  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            image: DecorationImage(
              image: (coverImage == null
                  ? NetworkImage(userModel.cover!)
                  : FileImage(coverImage!)) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () => CustomBottomSheet(
                type: "Cover",
                context: context,
                onPressedCamera: () => cubit.getCoverImage(
                  source: ImageSource.camera,
                ),
                onPressedGallery: () => cubit.getCoverImage(
                  source: ImageSource.gallery,
                ),
              ),
              icon: const Icon(
                Icons.camera_alt,
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
