import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/custom_image_bottom_sheet.dart';
import 'package:social_app/features/edit_profile/presentation/cubits/edit_profile_cubit.dart';

class EditCoverImage extends StatelessWidget {
  const EditCoverImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            final screenHeight = MediaQuery.of(context).size.height;

            final EditProfileCubit cubit =
                BlocProvider.of<EditProfileCubit>(context);

            return Container(
              height: screenHeight * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.r),
                  topRight: Radius.circular(5.r),
                ),
                image: DecorationImage(
                  image: (cubit.coverImage == null
                      ? NetworkImage(Helper.currentUser!.cover!)
                      : FileImage(cubit.coverImage!)) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Positioned(
          top: 16.h,
          right: 16.w,
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () => ShowCustomImageBottomSheet.show(
                context: context,
                onPressedGallery: () {
                  BlocProvider.of<EditProfileCubit>(context).getCoverImage(
                    source: ImageSource.gallery,
                  );
                },
                onPressedCamera: () {
                  BlocProvider.of<EditProfileCubit>(context).getCoverImage(
                    source: ImageSource.camera,
                  );
                },
                type: 'Cover',
              ),
              icon: Icon(
                Icons.camera_alt,
                color: AppColors.primaryColor,
                size: 25.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
