import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/auth_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/widgets/custom_dialog.dart';
import 'package:social_app/core/widgets/custom_text_form_field.dart';
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
  final TextEditingController _xUrlController = TextEditingController();
  final TextEditingController _facebookUrlController = TextEditingController();
  final TextEditingController _instagramUrlController = TextEditingController();
  final TextEditingController _githubUrlController = TextEditingController();

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
    _xUrlController.text = Helper.currentUser!.xUrl!;
    _facebookUrlController.text = Helper.currentUser!.facebookUrl!;
    _instagramUrlController.text = Helper.currentUser!.instagramUrl!;
    _githubUrlController.text = Helper.currentUser!.githubUrl!;
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
    _xUrlController.dispose();
    _facebookUrlController.dispose();
    _instagramUrlController.dispose();
    _githubUrlController.dispose();
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
                    state: state,
                    updateUserParams: UpdateUserParams(
                      name: _nameController.text.trim(),
                      phone: _phoneController.text,
                      bio: _bioController.text.trim(),
                      email: _emailController.text.trim(),
                      xUrl: '${AppStrings.xUrl}${_xUrlController.text.trim()}',
                      instagramUrl:
                          '${AppStrings.instagramUrl}${_instagramUrlController.text.trim()}',
                      facebookUrl: _facebookUrlController.text.trim(),
                      githubUrl:
                          '${AppStrings.githubUrl}${_githubUrlController.text.trim()}',
                    ),
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
                CustomTextFormField(
                  controller: _xUrlController,
                  hintText: 'Username',
                  prefixIcon: Image.asset(AppAssets.iconsGreyX),
                  keyboardType: TextInputType.url,
                  validating: (String? val) => AuthHelper.validateLink(val),
                ),
                const TextFormFieldSeparator(),
                CustomTextFormField(
                  controller: _instagramUrlController,
                  hintText: 'Username',
                  prefixIcon: Image.asset(AppAssets.iconsGreyInstagram),
                  keyboardType: TextInputType.url,
                  validating: (String? val) => AuthHelper.validateLink(val),
                ),
                const TextFormFieldSeparator(),
                CustomTextFormField(
                  controller: _facebookUrlController,
                  hintText: 'Facebook Link',
                  prefixIcon: Image.asset(AppAssets.iconsGreyFacebook),
                  keyboardType: TextInputType.url,
                  validating: (String? val) => AuthHelper.validateLink(val),
                ),
                const TextFormFieldSeparator(),
                CustomTextFormField(
                  controller: _githubUrlController,
                  hintText: 'Username',
                  prefixIcon: Image.asset(AppAssets.iconsGreyGithub),
                  keyboardType: TextInputType.url,
                  validating: (String? val) => AuthHelper.validateLink(val),
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
    if (_checkInfoChanged() && _formKey.currentState!.validate()) {
      CustomDialog.show(
        context: context,
        state: CustomDialogStates.warning,
        message: 'Nothing changed to update',
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
          xUrl: _xUrlController.text.trim(),
          instagramUrl: _instagramUrlController.text.trim(),
          facebookUrl: _facebookUrlController.text.trim(),
          githubUrl: _githubUrlController.text.trim(),
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
        Helper.currentUser!.bio == _bioController.text.trim() &&
        Helper.currentUser!.xUrl == _xUrlController.text.trim() &&
        Helper.currentUser!.instagramUrl ==
            _instagramUrlController.text.trim() &&
        Helper.currentUser!.facebookUrl == _facebookUrlController.text.trim() &&
        Helper.currentUser!.githubUrl == _githubUrlController.text.trim();
  }

  void _controlEditProfileState(
    EditProfileState state,
    BuildContext context,
  ) async {
    if (state is UpdateUserSuccess) {
      _handleUpdateUserSuccess(context);
    }

    if (state is UploadImageError) {
      CustomDialog.show(
        context: context,
        state: CustomDialogStates.error,
        message: state.error,
      );
    }
  }

  void _handleUpdateUserSuccess(BuildContext context) {
    BlocProvider.of<UserCubit>(context).getUserData().then((value) {
      BlocProvider.of<EditProfileCubit>(context)
          .updateUserPosts()
          .then((value) {
        BlocProvider.of<EditProfileCubit>(context).updateUserLikes().then(
          (value) {
            BlocProvider.of<EditProfileCubit>(context)
                .updateUserComments()
                .then((value) {
              CustomDialog.show(
                context: context,
                state: CustomDialogStates.success,
                message: 'User updated successfully',
              );
            });
          },
        );
      });
    });
  }
}
