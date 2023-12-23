import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/router/app_router.dart';
import 'package:social_app/config/themes/cubit/themes_cubit.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/config/themes/app_themes.dart';

import 'package:social_app/service_locator.dart';
import 'package:social_app/core/utils/size_config.dart';
import 'package:social_app/linkup/domain/app_repo.dart';
import 'package:social_app/linkup/presentation/views/manager/app_cubit.dart';

class LinkupApp extends StatelessWidget {
  // final Widget? startingScreen;
  // final String? uId;
  const LinkupApp(
      // this.startingScreen,
      // this.uId,

      {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScreenUtilInit(
      designSize: const Size(423, 887),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<ThemesCubit>(),
          )
          // BlocProvider(
          //   create: (context) => AppCubit(getIt.get<AppRepo>())
          //     ..getUserData(uId)
          //     ..getPosts(),
          // ),
          // BlocProvider(create: (context) => ThemeService()),
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
