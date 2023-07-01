import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/global/app_styles.dart';
import 'package:social_app/core/widgets/custom_button.dart';
import 'package:social_app/features/profile/presentation/views/edit_profile_view.dart';
import 'package:social_app/core/widgets/user_data.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

import '../../../../core/models/user_model.dart';
import '../../../../shared/constants.dart';
import '../widgets/me_profile_and_cover_images.dart';
import '../widgets/sign_out_floating_button.dart';

class MeView extends StatelessWidget {
  const MeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        UserModel userModel = SocialAppCubit.getObject(context).model!;
        return Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 220,
                      child: MeProfileAndCoverImages(userModel: userModel),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      userModel.name!,
                      style: AppStyles.bodyLarge.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userModel.bio!,
                      style: AppStyles.caption.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
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
                    const SizedBox(height: 10),
                    CustomButton(
                      buttonText: "Edit Profile",
                      onPressed: () => navigateTo(
                        context,
                        const EditProfileView(),
                      ),
                      height: 13,
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
