import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/core/widgets/custom_get_back_button.dart';
import 'package:social_app/features/auth/presentation/widgets/auth_view_sub_title.dart';
import 'package:social_app/features/auth/presentation/widgets/auth_view_title.dart';
import 'package:social_app/features/auth/presentation/widgets/have_account_or_not_text.dart';
import 'package:social_app/features/auth/presentation/widgets/sign_up/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: CustomFillingContainer(
              child: CustomContentContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const AuthViewTitle(title: 'SIGN UP'),
                        Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          child: const CustomGetBackButton(hasShadow: true),
                        ),
                      ],
                    ),
                    const AuthViewSubTitle(
                      subTitle: "Let's create you a new account",
                    ),
                    SizedBox(height: 30.h),
                    const SignUpForm(),
                    SizedBox(height: 10.h),
                    const Spacer(),
                    HaveAccountOrNotText(
                      question: 'Already have an account?',
                      buttonText: 'Sign in',
                      onTap: () => context.back(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
