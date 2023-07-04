import 'package:flutter/material.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/user_data.dart';
import '/core/models/user_model.dart';

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
              height: SizeConfig.screenHeight! * 0.3,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      height: SizeConfig.screenHeight! * 0.25,
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
            SizedBox(height: SizeConfig.screenHeight! * 0.015),
            Text(
              userModel.name!,
              style: AppStyles.bodyLarge.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.008),
            Text(
              userModel.bio!,
              style: AppStyles.bodySmall.copyWith(fontSize: 15),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.008),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.phone,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(width: SizeConfig.screenWidth! * 0.008),
                Text(
                  userModel.phone!,
                  style: AppStyles.caption.copyWith(fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.008),
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
