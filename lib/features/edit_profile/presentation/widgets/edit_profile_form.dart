import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/auth_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
import 'package:social_app/core/widgets/custom_toast.dart';
import 'package:social_app/core/widgets/main_button.dart';
import 'package:social_app/features/auth/presentation/widgets/text_form_field_separator.dart';
import 'package:social_app/features/edit_profile/presentation/cubits/edit_profile_cubit.dart';
import 'package:social_app/features/edit_profile/domain/entities/update_user_params.dart';
import 'package:social_app/features/edit_profile/presentation/widgets/confirm_editing_buttons.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autoValidateMode;

  @override
  void initState() {
    _assignValuesToControllers();
    _initFormAttributes();
    super.initState();
  }

  void _assignValuesToControllers() {
    _nameController.text = Helper.currentUser!.name!;
    _bioController.text = Helper.currentUser!.bio!;
    _phoneController.text = Helper.currentUser!.phone!;
    _emailController.text = Helper.currentUser!.email!;
  }

  void _initFormAttributes() {
    _formKey = GlobalKey<FormState>();
    autoValidateMode = AutovalidateMode.disabled;
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _nameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) => _controlEditProfileState(state, context),
      builder: (context, state) {
        final EditProfileCubit cubit =
            BlocProvider.of<EditProfileCubit>(context);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Form(
            key: _formKey,
            autovalidateMode: autoValidateMode,
            child: Column(
              children: <Widget>[
                if (cubit.profileImage != null)
                  ConfirmEditingButtons(
                    cubit: cubit,
                    name: _nameController.text.trim(),
                    phone: _phoneController.text,
                    bio: _bioController.text.trim(),
                    email: _emailController.text.trim(),
                    state: state,
                  ),
                if (cubit.profileImage != null || cubit.coverImage != null)
                  const TextFormFieldSeparator(),
                CustomTextFormField(
                  prefixIcon: Image.asset(AppAssets.iconsPerson),
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  hintText: 'Username',
                  validating: (String? val) => AuthHelper.validatingField(
                    fieldName: 'Username',
                    value: val,
                  ),
                ),
                const TextFormFieldSeparator(),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: Image.asset(AppAssets.iconsEmail),
                  validating: (String? val) =>
                      AuthHelper.validatingEmailField(value: val),
                ),
                const TextFormFieldSeparator(),
                CustomTextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  controller: _bioController,
                  hintText: 'Bio',
                  prefixIcon: Image.asset(AppAssets.iconsInfo),
                  validating: (String? val) => AuthHelper.validatingField(
                    fieldName: 'Bio',
                    value: val,
                  ),
                ),
                const TextFormFieldSeparator(),
                CustomTextFormField(
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  prefixIcon: Image.asset(AppAssets.iconsPhone),
                  keyboardType: TextInputType.phone,
                  validating: (String? val) => AuthHelper.validatingField(
                    fieldName: 'Phone number',
                    value: val,
                  ),
                ),
                const TextFormFieldSeparator(),
                MainButton(
                  child: state is UpdateUserLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Update",
                          style: AppTextStyles.textStyle23Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                  onPressed: () => _update(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _update(BuildContext context) {
    if (_checkInfoChanged()) {
      CustomToast.showToast(
        text: 'Nothing changed to update',
        state: CustomToastState.warning,
      );
    }

    if (_formKey.currentState!.validate() && _checkInfoChanged() == false) {
      AuthHelper.keyboardUnfocus(context);
      BlocProvider.of<EditProfileCubit>(context).updateUser(
        params: UpdateUserParams(
          name: _nameController.text.trim(),
          phone: _phoneController.text,
          bio: _bioController.text.trim(),
          email: _emailController.text.trim(),
        ),
      );
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  bool _checkInfoChanged() {
    return Helper.currentUser!.name == _nameController.text.trim() &&
        Helper.currentUser!.phone == _phoneController.text &&
        Helper.currentUser!.bio == _bioController.text.trim();
  }

  void _controlEditProfileState(
    EditProfileState state,
    BuildContext context,
  ) async {
    if (state is UpdateUserSuccess) {
      _handleUpdateUserSuccess(context);
    }

    if (state is UploadImageError) {
      CustomToast.showToast(
        text: state.error,
        state: CustomToastState.error,
      );
    }
  }

  void _handleUpdateUserSuccess(BuildContext context) {
    BlocProvider.of<UserCubit>(context).getUserData().then((value) {
      BlocProvider.of<EditProfileCubit>(context)
          .updateUserPosts()
          .then((value) {
        BlocProvider.of<UserCubit>(context)
            .getUserPosts(uId: Helper.uId!)
            .then((value) {
          CustomToast.showToast(
            text: 'User updated successfully',
            state: CustomToastState.success,
          );
        });
      });
    });
  }
}
