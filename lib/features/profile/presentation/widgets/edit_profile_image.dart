import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/custom_bottom_sheet.dart';
import '../../../../layout/cubit/cubit.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage({
    Key? key,
    required this.profileImage,
    required this.userModel,
    required this.cubit,
  }) : super(key: key);

  final File? profileImage;
  final UserModel userModel;
  final SocialAppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          radius: 54,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: (profileImage == null
                ? NetworkImage(userModel.image!)
                : FileImage(profileImage!)) as ImageProvider,
          ),
        ),
        IconButton(
          onPressed: () => CustomBottomSheet(
            type: "Profile",
            context: context,
            onPressedCamera: () => cubit.getProfileImage(
              source: ImageSource.camera,
            ),
            onPressedGallery: () => cubit.getProfileImage(
              source: ImageSource.gallery,
            ),
          ),
          icon: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.camera_alt,
              color: AppColors.primaryColor,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
