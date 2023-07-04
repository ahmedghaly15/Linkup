import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/core/global/app_texts.dart';
import '/core/global/app_theme.dart';
import '/core/services/theme_service.dart';
import '/core/utils/service_locator.dart';
import '/features/auth/presentation/view/auth_view.dart';
import '/layout/domain/app_repo.dart';
import '/layout/presenetation/view/layout_view.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/cache_helper.dart';
import 'core/utils/firebase_options.dart';
import 'core/utils/helper.dart';
import 'core/utils/size_config.dart';
import 'layout/presenetation/view/manager/app_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();

  ServiceLocator().setupServiceLocators();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.initSharedPref();

  Helper.uId = CacheHelper.getStringData(key: 'uId');

  Widget startingScreen;

  if (Helper.uId != null) {
    startingScreen = const LayoutView();
  } else {
    startingScreen = const AuthView();
  }

  runApp(
    LinkupApp(
      startingScreen,
      Helper.uId,
    ),
  );
}

// TODO: Add functionality to tags TextButton in NewPostView

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
          create: (context) => AppCubit(serviceLocator.get<AppRepo>())
            ..getUserData(uId)
            ..getPosts(),
        ),
        BlocProvider(create: (context) => ThemeService()),
      ],
      child: BlocBuilder<ThemeService, bool>(
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        builder: (context, isDark) {
          return GetMaterialApp(
            title: AppTexts.appTitle,
            debugShowCheckedModeBanner: false,
            theme: isDark ? AppTheme.darkTheme() : AppTheme.lightTheme(),
            // darkTheme: AppTheme.darkTheme(),
            // themeMode: ThemeService().theme,
            home: startingScreen,
          );
        },
      ),
    );
  }
}
