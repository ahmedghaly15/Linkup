import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/app_router.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/posts/presentation/cubits/posts_cubit.dart';
import 'package:social_app/features/users/presentation/cubits/user_cubit.dart';
import 'package:social_app/service_locator.dart';

class LinkupApp extends StatelessWidget {
  const LinkupApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(423, 887),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<ThemesCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<UserCubit>()..getUserData(),
          ),
          BlocProvider(
            create: (context) => getIt.get<PostsCubit>()
              ..getPosts()
              ..getLikedPostsByMe(),
          ),
        ],
        child: BlocBuilder<ThemesCubit, ThemeData>(
          buildWhen: (previousState, nextState) {
            return previousState != nextState;
          },
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
