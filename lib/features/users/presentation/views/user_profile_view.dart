import 'package:flutter/material.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/users/presentation/widgets/user_profile_view_body.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserProfileViewBody(user: user),
    );
  }
}
