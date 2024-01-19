import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/custom_image_bottom_sheet.dart';
import 'package:social_app/features/edit_profile/presentation/cubits/edit_profile_cubit.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            final EditProfileCubit cubit =
                BlocProvider.of<EditProfileCubit>(context);

            return CircleAvatar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              radius: 60.r,
              child: CircleAvatar(
                radius: 55.r,
                backgroundImage: (cubit.profileImage == null
                    ? NetworkImage(Helper.currentUser!.image!)
                    : FileImage(cubit.profileImage!)) as ImageProvider,
              ),
            );
          },
        ),
        Positioned(
          bottom: 8.h,
          right: 8.w,
          child: Container(
            height: 32.h,
            width: 32.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Helper.isDark(context)
                  ? AppColors.darkPrimaryColor
                  : AppColors.scaffoldBackgroundClr,
              boxShadow: <BoxShadow>[
                Helper.postShadow(context),
              ],
            ),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () => ShowCustomImageBottomSheet.show(
                context: context,
                onPressedGallery: () {
                  BlocProvider.of<EditProfileCubit>(context).getProfileImage(
                    source: ImageSource.gallery,
                  );
                },
                onPressedCamera: () {
                  BlocProvider.of<EditProfileCubit>(context).getProfileImage(
                    source: ImageSource.camera,
                  );
                },
                type: 'Profile',
              ),
              child: Icon(
                Icons.camera_alt,
                color: AppColors.primaryColor,
                size: 20.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
