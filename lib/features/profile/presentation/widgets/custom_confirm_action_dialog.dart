import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/main_button.dart';
import 'package:social_app/core/widgets/positioned_app_icon.dart';
import 'package:social_app/features/profile/presentation/widgets/custom_outline_button.dart';

class CustomConfirmActionDialog {
  static void show({
    required BuildContext context,
    required VoidCallback outlineButtonOnPressed,
    required String outlineButtonText,
    required String message,
    Color cancelButtonBackgroundColor = AppColors.primaryColor,
    Color outlineButtonBorderColor = AppColors.primaryColor,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, _, __) => const SizedBox(),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation1, animation2, widget) {
        return Material(
          type: MaterialType.transparency,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 24.h,
                        horizontal: 8.w,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        color: Helper.isDark(context)
                            ? AppColors.darkPrimaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(24.r)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 8.h),
                          Text(
                            message,
                            style: AppTextStyles.textStyle20Bold,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40.h),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: MainButton(
                                  onPressed: () => context.back(),
                                  text: 'Cancel',
                                  backgroundColor: cancelButtonBackgroundColor,
                                  textStyle:
                                      AppTextStyles.textStyle18Bold.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              CustomOutlineButton(
                                onPressed: outlineButtonOnPressed,
                                text: outlineButtonText,
                                borderColor: outlineButtonBorderColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const PositionedAppIcon(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
