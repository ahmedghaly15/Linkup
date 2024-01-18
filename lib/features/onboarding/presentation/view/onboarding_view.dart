import 'package:flutter/material.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/onboarding/presentation/widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Helper.backgroundImageDecoration(),
        child: const OnboardingViewBody(),
      ),
    );
  }
}
