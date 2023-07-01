import 'package:flutter/material.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../layout/cubit/cubit.dart';
import '../../../../layout/cubit/states.dart';

class ConfirmEditingButtons extends StatelessWidget {
  const ConfirmEditingButtons({
    Key? key,
    required this.cubit,
    required this.nameController,
    required this.phoneController,
    required this.bioController,
    required this.state,
  }) : super(key: key);

  final SocialAppCubit cubit;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController bioController;
  final SocialAppStates state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (cubit.profileImage != null)
          Expanded(
            child: Column(
              children: <Widget>[
                CustomButton(
                  buttonText: "Upload Profile Image",
                  onPressed: () => cubit.uploadProfileImage(
                    context: context,
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  ),
                  width: 15,
                  height: 10,
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (state is UploadingProfileImageLoadingState)
                  const SizedBox(height: 5),
                if (state is UploadingProfileImageLoadingState)
                  const SizedBox(
                    width: 150,
                    child: LinearProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(width: 5),
        if (cubit.coverImage != null)
          Expanded(
            child: Column(
              children: <Widget>[
                CustomButton(
                  buttonText: "Upload Cover Image",
                  onPressed: () => cubit.uploadCoverImage(
                    context: context,
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  ),
                  width: 15,
                  height: 10,
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (state is UploadingCoverImageLoadingState)
                  const SizedBox(height: 5),
                if (state is UploadingCoverImageLoadingState)
                  const SizedBox(
                    width: 150,
                    child: LinearProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
