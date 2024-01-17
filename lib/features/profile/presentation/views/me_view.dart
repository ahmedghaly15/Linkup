import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/user_information.dart';
import 'package:social_app/core/widgets/user_posts.dart';
import 'package:social_app/features/profile/presentation/widgets/me_profile_and_cover_images.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  State<MeView> createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUserPosts(uId: Helper.uId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) => _handleUserState(state, context),
      builder: (context, state) {
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: screenHeight * 0.3,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: MeProfileAndCoverImages(me: Helper.currentUser!),
              ),
            ),
          ],
          body: CustomScrollView(
            physics: AppConstants.physics,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: UserInformation(user: Helper.currentUser!),
              ),
              UserPosts(uId: Helper.uId!),
            ],
          ),
        );
      },
    );
  }

  void _handleUserState(UserState state, BuildContext context) {
    if (state is UserSignOutSuccess) {
      context.navigateAndReplace(newRoute: Routes.signInRoute);
    }
  }
}
