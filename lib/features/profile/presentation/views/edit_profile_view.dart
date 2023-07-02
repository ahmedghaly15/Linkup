import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/utils/helper.dart';
import '../../../../layout/presenetation/view/manager/app_cubit.dart';
import '../../../../layout/presenetation/view/manager/app_states.dart';
import '../widgets/edit_profile_view_body.dart';
import '/core/widgets/custom_text_button.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        UserModel userModel = Helper.model!;
        final TextEditingController nameController = TextEditingController();
        final TextEditingController bioController = TextEditingController();
        final TextEditingController phoneController = TextEditingController();
        final GlobalKey<FormState> formKey = GlobalKey();
        nameController.text = userModel.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        AppCubit cubit = AppCubit.getObject(context);
        File? profileImage = cubit.profileImage;
        File? coverImage = cubit.coverImage;

        return Scaffold(
          backgroundColor: context.theme.colorScheme.background,
          appBar: buildAppBar(
            context,
            cubit,
            nameController,
            phoneController,
            bioController,
          ),
          body: EditProfileViewBody(
            coverImage: coverImage,
            userModel: userModel,
            cubit: cubit,
            profileImage: profileImage,
            nameController: nameController,
            phoneController: phoneController,
            bioController: bioController,
            formKey: formKey,
            state: state,
          ),
        );
      },
    );
  }

  AppBar buildAppBar(
      BuildContext context,
      AppCubit cubit,
      TextEditingController nameController,
      TextEditingController phoneController,
      TextEditingController bioController) {
    return Helper.appBarBuilder(
      context: context,
      title: "Edit Profile",
      actions: <Widget>[
        CustomTextButton(
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
    );
  }
}
