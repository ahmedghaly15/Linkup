import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/user_model.dart';
import '../../styles/thems.dart';
import '/layout/cubit/cubit.dart';
import '/layout/cubit/states.dart';
import '/modules/edit_profile/edit_profile_screen.dart';
import '/shared/components/default_button.dart';
import '/shared/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
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
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(userModel.cover!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 54,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(userModel.image!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      userModel.name!,
                      style: bodyLarge.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userModel.bio!,
                      style: caption.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          buildProfileData(context, 0, "Posts"),
                          buildProfileData(context, 0, "Photos"),
                          buildProfileData(context, 0, "Followers"),
                          buildProfileData(context, 0, "Following"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    DefaultButton(
                      buttonText: "Edit Profile",
                      onPressed: () => navigateTo(
                        context,
                        const EditProfileScreen(),
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
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 5.0,
                ),
                child: FloatingActionButton.extended(
                  heroTag: "Floating Sign Out Button",
                  backgroundColor: Colors.redAccent,
                  onPressed: () => signOut(context),
                  label: Text(
                    "Sign out",
                    style: bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildProfileData(BuildContext context, int count, String label) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            "$count",
            style: bodyLarge,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: caption,
          ),
        ],
      ),
    );
  }
}
