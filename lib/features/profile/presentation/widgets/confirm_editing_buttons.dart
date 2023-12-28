import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/features/profile/domain/entities/update_user_params.dart';
import 'package:social_app/features/profile/presentation/cubits/edit_profile_cubit.dart';
import 'package:social_app/features/profile/presentation/widgets/confirm_editing_button.dart';

class ConfirmEditingButtons extends StatelessWidget {
  const ConfirmEditingButtons({
    Key? key,
    required this.cubit,
    required this.nameController,
    required this.phoneController,
    required this.bioController,
    required this.state,
  }) : super(key: key);

  final EditProfileCubit cubit;
  final EditProfileState state;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (cubit.profileImage != null)
          Expanded(
            child: Column(
              children: <Widget>[
                ConfirmEditingButton(
                  buttonText: "Update Profile Image",
                  onPressed: () => cubit.uploadProfileImage(
                    params: UpdateUserParams(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    ),
                  ),
                ),
                if (state is UploadProfileImageLoading) ...[
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: screenWidth * 0.4,
                    child: const LinearProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        SizedBox(width: 15.w),
        if (cubit.coverImage != null)
          Expanded(
            child: Column(
              children: <Widget>[
                ConfirmEditingButton(
                  buttonText: "Update Cover Image",
                  onPressed: () => cubit.uploadCoverImage(
                    params: UpdateUserParams(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    ),
                  ),
                ),
                if (state is UploadCoverImageLoading) ...[
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: screenWidth * 0.4,
                    child: const LinearProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
