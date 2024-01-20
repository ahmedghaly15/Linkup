import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/themes/app_text_styles.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/service_locator.dart';

class FollowersAndFollowing extends StatelessWidget {
  const FollowersAndFollowing({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            StreamBuilder(
              stream: _followersStream(),
              builder: (context, snapshot) {
                int followersCount = snapshot.data?.docs.length ?? 0;
                return Text(
                  '$followersCount',
                  style: AppTextStyles.textStyle15.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            SizedBox(height: 5.h),
            Text(
              'Followers',
              style: AppTextStyles.textStyle13,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            StreamBuilder(
              stream: _followingStream(),
              builder: (context, snapshot) {
                int followingCount = snapshot.data?.docs.length ?? 0;

                return Text(
                  '$followingCount',
                  style: AppTextStyles.textStyle15.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            SizedBox(height: 5.h),
            Text(
              'Following',
              style: AppTextStyles.textStyle13,
            ),
          ],
        ),
      ],
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _followersStream() {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(user.uId)
        .collection(AppStrings.followers)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _followingStream() {
    return getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(user.uId)
        .collection(AppStrings.following)
        .snapshots();
  }
}
