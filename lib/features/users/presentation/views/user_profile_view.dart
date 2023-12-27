import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import 'package:social_app/features/users/presentation/widgets/user_profile_view_body.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUserPosts(uId: widget.user.uId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserProfileViewBody(user: widget.user),
    );
  }
}
