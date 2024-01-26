import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_colors.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/positioned_app_icon.dart';

enum CustomDialogStates { warning, success, error }

class CustomDialog {
  static void show({
    required BuildContext context,
    required CustomDialogStates state,
    required String message,
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
                      padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        top: 24.h,
                        bottom: 8.h,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _chooseSnackBarTitle(state),
                            style: AppTextStyles.textStyle18Bold,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            message,
                            style: AppTextStyles.textStyle15,
                          ),
                          SizedBox(height: 16.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => context.back(),
                              child: Text(
                                'Done',
                                style:
                                    AppTextStyles.textStyle16SemiBold.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
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

  static String _chooseSnackBarTitle(
    CustomDialogStates state,
  ) {
    String title;

    switch (state) {
      case CustomDialogStates.error:
        title = 'Opps!';
        break;
      case CustomDialogStates.warning:
        title = 'Warning';
        break;

      case CustomDialogStates.success:
        title = 'Success!';
        break;
    }

    return title;
  }
}
