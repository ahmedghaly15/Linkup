import 'package:flutter/material.dart';
import 'package:social_app/core/models/user_model.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/widgets/user_data.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({Key? key, required this.userModel})
      : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 220,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(userModel.cover!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    radius: 54,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userModel.image!),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Text(
              userModel.name!,
              style: AppStyles.bodyLarge.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              userModel.bio!,
              style: AppStyles.bodySmall.copyWith(fontSize: 15),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Row(
                children: <Widget>[
                  UserData(count: 0, label: "Posts"),
                  UserData(count: 0, label: "Photos"),
                  UserData(count: 0, label: "Followers"),
                  UserData(count: 0, label: "Following"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
