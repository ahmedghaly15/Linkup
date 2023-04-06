import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/input_field.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/styles/colors.dart';
import 'package:social_app/styles/iconbroken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel userModel = SocialAppCubit.getObject(context).model!;
        final TextEditingController nameController = TextEditingController();
        final TextEditingController bioController = TextEditingController();
        final TextEditingController phoneController = TextEditingController();
        final GlobalKey<FormState> formKey = GlobalKey();
        nameController.text = userModel.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        File? profileImage = SocialAppCubit.getObject(context).profileImage;
        File? coverImage = SocialAppCubit.getObject(context).coverImage;
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: appBarBuilder(
              context: context,
              title: "Edit Profile",
              actions: <Widget>[
                defaultTextButton(
                  onPressed: () {
                    SocialAppCubit.getObject(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  title: "UPDATE",
                ),
                const SizedBox(width: 5),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  if (state is UserUpdateLoadingState)
                    const LinearProgressIndicator(color: defaultColor),
                  if (state is UserUpdateLoadingState)
                    const SizedBox(height: 10),
                  SizedBox(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: <Widget>[
                              Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: (coverImage == null
                                            ? NetworkImage(userModel.cover!)
                                            : FileImage(coverImage))
                                        as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    onPressed: () => buildBottomSheet(
                                      context: context,
                                      onPressedCamera: () =>
                                          SocialAppCubit.getObject(context)
                                              .getCoverImage(
                                        source: ImageSource.camera,
                                      ),
                                      onPressedGallery: () =>
                                          SocialAppCubit.getObject(context)
                                              .getCoverImage(
                                        source: ImageSource.gallery,
                                      ),
                                    ),
                                    icon: const Icon(
                                      IconBroken.camera,
                                      color: defaultColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 54,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: (profileImage == null
                                    ? NetworkImage(userModel.image!)
                                    : FileImage(profileImage)) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () => buildBottomSheet(
                                context: context,
                                onPressedCamera: () =>
                                    SocialAppCubit.getObject(context)
                                        .getProfileImage(
                                  source: ImageSource.camera,
                                ),
                                onPressedGallery: () =>
                                    SocialAppCubit.getObject(context)
                                        .getProfileImage(
                                  source: ImageSource.gallery,
                                ),
                              ),
                              icon: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  IconBroken.camera,
                                  color: defaultColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          InputField(
                            hint: "Name",
                            controller: nameController,
                            textCapitalization: TextCapitalization.words,
                            validating: (val) {
                              if (val!.isEmpty) {
                                return "Name can't be blank!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            prefixIcon: const Icon(IconBroken.user),
                            // hintStyle: const TextStyle(
                            //   fontSize: 18,
                            //   color: Colors.black,
                            // ),
                            obsecure: false,
                          ),
                          const SizedBox(height: 10),
                          InputField(
                            hint: "Bio",
                            controller: bioController,
                            textCapitalization: TextCapitalization.none,
                            validating: (val) {
                              if (val!.isEmpty) {
                                return "Bio can't be blank!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            prefixIcon: const Icon(IconBroken.infoCircle),
                            // hintStyle: const TextStyle(
                            //   fontSize: 18,
                            //   color: Colors.black,
                            // ),
                            obsecure: false,
                          ),
                          const SizedBox(height: 10),
                          InputField(
                            hint: "Phone",
                            controller: phoneController,
                            textCapitalization: TextCapitalization.none,
                            validating: (val) {
                              if (val!.isEmpty) {
                                return "Phone can't be blank!";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            prefixIcon: const Icon(IconBroken.call),
                            // hintStyle: const TextStyle(
                            //   fontSize: 18,
                            //   color: Colors.black,
                            // ),
                            obsecure: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void buildBottomSheet({
    required BuildContext context,
    required void Function()? onPressedGallery,
    required void Function()? onPressedCamera,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: BottomSheet(
              enableDrag: true,
              onClosing: () => navigateBack(context),
              builder: (context) {
                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  children: <Widget>[
                    const Text(
                      "Pick Profile Picture",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: onPressedGallery,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            fixedSize: const Size(180, 130),
                          ),
                          child: Image.asset(
                            'assets/images/add_image.png',
                            width: 180,
                            height: 100,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onPressedCamera,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            fixedSize: const Size(180, 130),
                          ),
                          child: Image.asset(
                            'assets/images/camera.png',
                            width: 180,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
