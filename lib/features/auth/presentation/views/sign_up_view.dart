import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/features/auth/presentation/widgets/auth_view_sub_title.dart';
import 'package:social_app/features/auth/presentation/widgets/auth_view_title.dart';
import 'package:social_app/features/auth/presentation/widgets/custom_auth_sliver_app_bar.dart';
import 'package:social_app/features/auth/presentation/widgets/have_account_or_not_text.dart';
import 'package:social_app/features/auth/presentation/widgets/sign_up/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const CustomAuthSliverAppBar(hasLeading: true),
            SliverPadding(
              padding: AppConstants.authHorizontalPadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const AuthViewTitle(title: 'SIGN UP'),
                    const AuthViewSubTitle(
                      subTitle: "Let's create you a new account",
                    ),
                    SizedBox(height: 30.h),
                    const SignUpForm(),
                    SizedBox(height: 10.h),
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
                      question: 'Already have an account?',
                      buttonText: 'Sign in',
                      onTap: () => context.getBack(),
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
