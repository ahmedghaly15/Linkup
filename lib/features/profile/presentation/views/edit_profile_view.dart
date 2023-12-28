import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:social_app/features/profile/presentation/widgets/edit_cover_image.dart';
import 'package:social_app/features/profile/presentation/widgets/edit_profile_form.dart';
import 'package:social_app/features/profile/presentation/widgets/edit_profile_image.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: AppConstants.physics,
          slivers: [
            CustomSliverAppBar(
              title: 'Edit Profile',
              backOnPressed: () {
                BlocProvider.of<UserCubit>(context)
                    .getUserPosts(uId: Helper.currentUser!.uId!)
                    .then((value) {
                  context.getBack();
                });
              },
            ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.3,
                    child: const Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: EditCoverImage(),
                        ),
                        EditProfileImage(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const EditProfileForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
