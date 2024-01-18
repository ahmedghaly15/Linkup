import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/features/auth/presentation/widgets/auth_view_sub_title.dart';
import 'package:social_app/features/auth/presentation/widgets/auth_view_title.dart';
import 'package:social_app/features/auth/presentation/widgets/have_account_or_not_text.dart';
import 'package:social_app/features/auth/presentation/widgets/sign_in/sign_in_form.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

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
                    const AuthViewTitle(title: 'SIGN IN'),
                    const AuthViewSubTitle(
                      subTitle: "Sign in to communicate with friends",
                    ),
                    SizedBox(height: 30.h),
                    const SignInForm(),
                    SizedBox(height: 10.h),
                    const Spacer(),
                    HaveAccountOrNotText(
                      question: "Don't have an account?",
                      buttonText: 'Sign up',
                      onTap: () => context.navigateTo(
                        routeName: Routes.signUpRoute,
                      ),
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
