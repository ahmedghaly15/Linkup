import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/widgets/custom_content_container.dart';
import 'package:social_app/core/widgets/custom_filling_container.dart';
import 'package:social_app/core/widgets/custom_get_back_button.dart';
import 'package:social_app/features/edit_profile/presentation/widgets/edit_profile_form.dart';
import 'package:social_app/features/edit_profile/presentation/widgets/edit_profile_image.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFillingContainer(
        child: CustomContentContainer(
          child: CustomScrollView(
            physics: AppConstants.physics,
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: <Widget>[
                    const CustomGetBackButton(hasShadow: true),
                    const Spacer(),
                    Text(
                      'Edit Profile',
                      style: AppTextStyles.textStyle20Bold,
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    const EditProfileImage(),
                    SizedBox(height: 20.h),
                    const EditProfileForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
