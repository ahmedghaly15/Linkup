import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_text_styles.dart';
import 'package:social_app/features/auth/presentation/widgets/custom_auth_sliver_app_bar.dart';
import 'package:social_app/features/auth/presentation/widgets/have_account_or_not_text.dart';
import 'package:social_app/features/auth/presentation/widgets/sign_in/sign_in_form.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const CustomAuthSliverAppBar(),
            SliverPadding(
              padding: AppConstants.authHorizontalPadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      child: Text(
                        'LOGIN',
                        style: AppTextStyles.textStyle50Bold,
                      ),
                    ),
                    Text(
                      "Sign in to communicate with friends",
                      style: AppTextStyles.textStyle18,
                    ),
                    SizedBox(height: 30.h),
                    const SignInForm(),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: AppConstants.authHorizontalPadding,
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    HaveAccountOrNotText(
                      question: "Don't have an account?",
                      buttonText: 'Sign up',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
