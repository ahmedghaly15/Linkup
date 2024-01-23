import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/features/edit_profile/domain/entities/update_user_params.dart';
import 'package:social_app/features/edit_profile/presentation/cubits/edit_profile_cubit.dart';
import 'package:social_app/features/edit_profile/presentation/widgets/confirm_editing_button.dart';

class ConfirmEditingButtons extends StatelessWidget {
  const ConfirmEditingButtons({
    super.key,
    required this.cubit,
    required this.name,
    required this.phone,
    required this.bio,
    required this.state,
    required this.email,
  });

  final EditProfileCubit cubit;
  final EditProfileState state;
  final String email;
  final String name;
  final String phone;
  final String bio;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ConfirmEditingButton(
          buttonText: "Update Profile Image",
          onPressed: () => cubit.uploadProfileImage(
            params: UpdateUserParams(
              name: name,
              phone: phone,
              bio: bio,
              email: email,
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
        SizedBox(height: 8.h),
      ],
    );

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     if (cubit.profileImage != null)
    //       Expanded(
    //         child: Column(
    //           children: <Widget>[
    //             ConfirmEditingButton(
    //               buttonText: "Update Profile Image",
    //               onPressed: () => cubit.uploadProfileImage(
    //                 params: UpdateUserParams(
    //                   name: name,
    //                   phone: phone,
    //                   bio: bio,
    //                   email: email,
    //                 ),
    //               ),
    //             ),
    //             if (state is UploadProfileImageLoading) ...[
    //               SizedBox(height: 8.h),
    //               SizedBox(
    //                 width: screenWidth * 0.4,
    //                 child: const LinearProgressIndicator(
    //                   color: AppColors.primaryColor,
    //                 ),
    //               ),
    //             ],
    //           ],
    //         ),
    //       ),
    //     SizedBox(width: 15.w),
    //     if (cubit.coverImage != null)
    //       Expanded(
    //         child: Column(
    //           children: <Widget>[
    //             ConfirmEditingButton(
    //               buttonText: "Update Cover Image",
    //               onPressed: () => cubit.uploadCoverImage(
    //                 params: UpdateUserParams(
    //                   name: name,
    //                   phone: phone,
    //                   bio: bio,
    //                   email: email,
    //                 ),
    //               ),
    //             ),
    //             if (state is UploadCoverImageLoading) ...[
    //               SizedBox(height: 8.h),
    //               SizedBox(
    //                 width: screenWidth * 0.4,
    //                 child: const LinearProgressIndicator(
    //                   color: AppColors.primaryColor,
    //                 ),
    //               ),
    //             ],
    //           ],
    //         ),
    //       ),
    //   ],
    // );
  }
}
