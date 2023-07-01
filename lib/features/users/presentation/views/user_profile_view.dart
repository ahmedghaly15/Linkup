import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/helper.dart';
import 'package:social_app/features/users/presentation/widgets/user_profile_view_body.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialAppCubit, SocialAppStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.theme.colorScheme.background,
          appBar: Helper.appBarBuilder(context: context),
          body: UserProfileViewBody(userModel: userModel),
        );
      },
    );
  }
}
