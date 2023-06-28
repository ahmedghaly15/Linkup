import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/models/user_model.dart';
import '../../core/utils/helper.dart';
import '/layout/cubit/cubit.dart';
import '/layout/cubit/states.dart';
import '/shared/components/default_button.dart';
import '/shared/components/input_field.dart';
import '/shared/constants.dart';
import '/styles/thems.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

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
        SocialAppCubit cubit = SocialAppCubit.getObject(context);
        File? profileImage = cubit.profileImage;
        File? coverImage = cubit.coverImage;
        return Scaffold(
          backgroundColor: context.theme.colorScheme.background,
          appBar: appBarBuilder(
            context: context,
            title: "Edit Profile",
            actions: <Widget>[
              defaultTextButton(
                onPressed: () {
                  cubit.updateUser(
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
          body: SingleChildScrollView(
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
                                      type: "Cover",
                                      context: context,
                                      onPressedCamera: () =>
                                          cubit.getCoverImage(
                                        source: ImageSource.camera,
                                      ),
                                      onPressedGallery: () =>
                                          cubit.getCoverImage(
                                        source: ImageSource.gallery,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.camera_alt,
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
                                type: "Profile",
                                context: context,
                                onPressedCamera: () => cubit.getProfileImage(
                                  source: ImageSource.camera,
                                ),
                                onPressedGallery: () => cubit.getProfileImage(
                                  source: ImageSource.gallery,
                                ),
                              ),
                              icon: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
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
                  const SizedBox(height: 15),
                  // if (cubit.profileImage != null && cubit.coverImage != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (cubit.profileImage != null)
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              DefaultButton(
                                buttonText: "Upload Profile Image",
                                onPressed: () => cubit.uploadProfileImage(
                                  context: context,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                ),
                                width: 15,
                                height: 10,
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (state is UploadingProfileImageLoadingState)
                                const SizedBox(height: 5),
                              if (state is UploadingProfileImageLoadingState)
                                const SizedBox(
                                  width: 150,
                                  child: LinearProgressIndicator(
                                    color: defaultColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      const SizedBox(width: 5),
                      if (cubit.coverImage != null)
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              DefaultButton(
                                buttonText: "Upload Cover Image",
                                onPressed: () => cubit.uploadCoverImage(
                                  context: context,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                ),
                                width: 15,
                                height: 10,
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (state is UploadingCoverImageLoadingState)
                                const SizedBox(height: 5),
                              if (state is UploadingCoverImageLoadingState)
                                const SizedBox(
                                  width: 150,
                                  child: LinearProgressIndicator(
                                    color: defaultColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
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
                            prefixIcon: const Icon(Icons.person),
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
                            prefixIcon: const Icon(Icons.info),
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
                            prefixIcon: const Icon(Icons.phone),
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
}
