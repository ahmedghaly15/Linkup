import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/app_router.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/following_and_followers_cubit.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_followers/get_followers_cubit.dart';
import 'package:social_app/features/following_and_followers/presentation/cubit/get_following/get_following_cubit.dart';
import 'package:social_app/features/people_who_liked/presentation/cubit/people_who_liked_cubit.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_profile/user_profile_cubit.dart';
import 'package:social_app/service_locator.dart';

class LinkupApp extends StatelessWidget {
  const LinkupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<UserCubit>()
              ..getUserData()
              ..getPosts(),
          ),
          BlocProvider(
            create: (context) => getIt.get<ThemesCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<PostsCubit>(),
          ),
          BlocProvider(
            create: (context) =>
                getIt.get<UserProfileCubit>()..getUserPosts(uId: Helper.uId!),
          ),
          BlocProvider(
            create: (context) => getIt.get<FollowingAndFollowersCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<GetFollowersCubit>()..getFollowers(),
          ),
          BlocProvider(
            create: (context) => getIt.get<GetFollowingCubit>()..getFollowing(),
          ),
          BlocProvider(
            create: (context) => getIt.get<PeopleWhoLikedCubit>(),
          ),
        ],
        child: BlocBuilder<ThemesCubit, ThemeData>(
          builder: (context, themeState) {
            return MaterialApp(
              title: AppStrings.appTitle,
              debugShowCheckedModeBanner: false,
              theme: themeState,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
