import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/default_button.dart';
import 'package:social_app/shared/constants.dart';

import '../../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // For Getting The Screen Width
        // double screenWidth = MediaQuery.of(context).size.width;
        // For Getting The Screen Height
        // double screenHeight = MediaQuery.of(context).size.height;
        // Getting the model
        UserModel userModel = SocialAppCubit.getObject(context).model!;
        return SingleChildScrollView(
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
                const SizedBox(height: 5),
                Text(
                  userModel.name!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  userModel.bio!,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 15,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    // horizontal: 8.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "32",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Posts",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "20",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Photos",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "100k",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "1",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Following",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DefaultButton(
                  buttonText: "Edit Profile",
                  onPressed: () =>
                      navigateTo(context, const EditProfileScreen()),
                  height: 13,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                defaultTextButton(
                  onPressed: () => signOut(context),
                  title: "sign out",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
