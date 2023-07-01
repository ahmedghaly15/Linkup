import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/core/global/app_texts.dart';
import 'package:social_app/core/global/app_theme.dart';
import 'package:social_app/core/utils/service_locator.dart';
import 'package:social_app/features/auth/presentation/view/auth_view.dart';

import '/layout/cubit/cubit.dart';
import '/layout/social_layout.dart';
import 'core/services/theme_service.dart';
import 'core/utils/bloc_observer.dart';

import 'core/utils/helper.dart';
import 'core/utils/size_config.dart';
import 'firebase_options.dart';
import 'core/utils/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //===================== Initializing GetStorage =====================
  await GetStorage.init();

  ServiceLocator().setupServiceLocators();

  //===================== Observing My Bloc =====================
  Bloc.observer = MyBlocObserver();

  //===================== Initializing SharedPref =====================
  await CacheHelper.initSharedPref();

  Helper.uId = CacheHelper.getStringData(key: 'uId');

  Widget startingScreen;

  if (Helper.uId != null) {
    startingScreen = const SocialAppLayout();
  } else {
    startingScreen = const AuthView();
  }

  runApp(
    SocialApp(
      startingScreen,
      Helper.uId,
    ),
  );
}

// TODO: look at all SizedBox and use SizeConfig if it's not used
// TODO: Add functionality to tags TextButton in NewPostView

class SocialApp extends StatelessWidget {
  final Widget? startingScreen;
  final String? uId;
  const SocialApp(
    this.startingScreen,
    this.uId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => SocialAppCubit()
        ..getUserData(uId)
        ..getPosts(),
      child: GetMaterialApp(
        title: AppTexts.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeService().theme,
        home: startingScreen,
      ),
    );
  }
}
