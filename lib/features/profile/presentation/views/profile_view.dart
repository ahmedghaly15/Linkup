import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUserPosts(uId: Helper.uId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppAssets.imagesProfileBackground,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: const ProfileViewBody(),
    );
  }
}
