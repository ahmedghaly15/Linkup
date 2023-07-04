import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/utils/helper.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '../../../../layout/presenetation/view/manager/app_states.dart';
import '../widgets/me_profile_and_cover_images.dart';
import '../widgets/sign_out_floating_button.dart';
import '/core/global/app_navigator.dart';
import '/core/global/app_styles.dart';
import '/core/utils/size_config.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/user_data.dart';
import '/features/profile/presentation/views/edit_profile_view.dart';

class MeView extends StatelessWidget {
  const MeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        UserModel userModel = Helper.model!;
        return Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.3,
                      child: MeProfileAndCoverImages(userModel: userModel),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.015),
                    Text(
                      userModel.name!,
                      style: AppStyles.bodyLarge.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.008),
                    Text(
                      userModel.bio!,
                      style: AppStyles.caption.copyWith(fontSize: 15),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.008),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(width: SizeConfig.screenWidth! * 0.008),
                        Text(
                          userModel.phone!,
                          style: AppStyles.caption.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.008),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          UserData(count: 0, label: "Posts"),
                          UserData(count: 0, label: "Photos"),
                          UserData(count: 0, label: "Followers"),
                          UserData(count: 0, label: "Following"),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.015),
                    CustomButton(
                      buttonText: "Edit Profile",
                      onPressed: () => AppNavigator.navigateTo(
                        screen: const EditProfileView(),
                      ),
                      height: SizeConfig.screenHeight! * 0.065,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: SignOutFloatingButton(),
            ),
          ],
        );
      },
    );
  }
}
