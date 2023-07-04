import 'package:flutter/material.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '../../../../layout/presenetation/view/manager/app_states.dart';
import '/core/utils/size_config.dart';
import 'confirm_editing_button.dart';

class ConfirmEditingButtons extends StatelessWidget {
  const ConfirmEditingButtons({
    Key? key,
    required this.cubit,
    required this.nameController,
    required this.phoneController,
    required this.bioController,
    required this.state,
  }) : super(key: key);

  final AppCubit cubit;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController bioController;
  final AppStates state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (cubit.profileImage != null)
          Expanded(
            child: Column(
              children: <Widget>[
                ConfirmEditingButton(
                  buttonText: "Upload Profile Image",
                  onPressed: () => cubit.uploadProfileImage(
                    context: context,
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  ),
                ),
                if (state is UploadingProfileImageLoadingState)
                  SizedBox(height: SizeConfig.screenHeight! * 0.01),
                if (state is UploadingProfileImageLoadingState)
                  SizedBox(
                    width: SizeConfig.screenWidth! * 0.4,
                    child: const LinearProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
        SizedBox(width: SizeConfig.screenWidth! * 0.03),
        if (cubit.coverImage != null)
          Expanded(
            child: Column(
              children: <Widget>[
                ConfirmEditingButton(
                  buttonText: "Upload Cover Image",
                  onPressed: () => cubit.uploadCoverImage(
                    context: context,
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  ),
                ),
                if (state is UploadingCoverImageLoadingState)
                  SizedBox(height: SizeConfig.screenHeight! * 0.01),
                if (state is UploadingCoverImageLoadingState)
                  SizedBox(
                    width: SizeConfig.screenWidth! * 0.4,
                    child: const LinearProgressIndicator(
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
