import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/core/widgets/get_back_arrow.dart';
import 'package:social_app/features/auth/presentation/widgets/auth_view_sub_title.dart';
import 'package:social_app/features/auth/presentation/widgets/forgot_password/forgot_password_form.dart';
import 'package:social_app/features/auth/presentation/widgets/have_account_or_not_text.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const GetBackArrow(),
      ),
      body: Padding(
        padding: AppConstants.horizontalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'FORGOT PASSWORD',
              style: AppTextStyles.textStyle28Bold.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            const AuthViewSubTitle(
              subTitle: 'Enter your account to send you a reset password mail',
            ),
            SizedBox(height: 30.h),
            const ForgotPasswordForm(),
            HaveAccountOrNotText(
              question: "Don't have an account?",
              buttonText: 'Sign up',
              onTap: () => context.navigateTo(routeName: Routes.signUpRoute),
            ),
          ],
        ),
      ),
    );
  }
}
