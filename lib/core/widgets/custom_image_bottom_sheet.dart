import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/image_circle.dart';

class ShowCustomImageBottomSheet {
  static void show({
    required BuildContext context,
    required void Function()? onPressedGallery,
    required void Function()? onPressedCamera,
    required String type,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomImageBottomSheet(
        type: type,
        onPressedCamera: onPressedCamera,
        onPressedGallery: onPressedGallery,
      ),
    );
  }
}

class CustomImageBottomSheet extends StatelessWidget {
  const CustomImageBottomSheet({
    Key? key,
    this.onPressedGallery,
    this.onPressedCamera,
    required this.type,
  }) : super(key: key);

  final void Function()? onPressedGallery;
  final void Function()? onPressedCamera;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: BottomSheet(
        enableDrag: true,
        onClosing: () => context.getBack(),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: 25.h, top: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Pick $type Picture",
                  style: AppTextStyles.textStyle18,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ImageCircle(
                      onPressed: onPressedGallery,
                      icon: AppAssets.imagesAddImage,
                    ),
                    ImageCircle(
                      onPressed: onPressedCamera,
                      icon: AppAssets.imagesCamera,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
