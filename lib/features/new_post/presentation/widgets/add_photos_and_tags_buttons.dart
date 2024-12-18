import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/core/widgets/custom_image_bottom_sheet.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';

class AddPhotosAndTagsButtons extends StatelessWidget {
  const AddPhotosAndTagsButtons({
    super.key,
    required this.cubit,
  });

  final PostsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton.icon(
          onPressed: () => ShowCustomImageBottomSheet.show(
            type: "Post",
            context: context,
            onPressedCamera: () => cubit.getPostImage(
              source: ImageSource.camera,
            ),
            onPressedGallery: () => cubit.getPostImage(
              source: ImageSource.gallery,
            ),
          ),
          icon: Icon(
            Icons.image,
            color: AppColors.primaryColor,
            size: 22.w,
          ),
          label: const Text("Add photo"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("# Tags"),
        ),
      ],
    );
  }
}
