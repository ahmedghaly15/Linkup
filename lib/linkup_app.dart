import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/config/themes/app_themes.dart';

import 'package:social_app/service_locator.dart';
import 'package:social_app/core/utils/size_config.dart';
import 'package:social_app/layout/domain/app_repo.dart';
import 'package:social_app/layout/presentation/view/manager/app_cubit.dart';

class LinkupApp extends StatelessWidget {
  final Widget? startingScreen;
  final String? uId;
  const LinkupApp(
    this.startingScreen,
    this.uId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(getIt.get<AppRepo>())
            ..getUserData(uId)
            ..getPosts(),
        ),
        // BlocProvider(create: (context) => ThemeService()),
      ],
      child: GetMaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: startingScreen,
      ),
    );
  }
}
