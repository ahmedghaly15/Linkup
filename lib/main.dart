import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/layout/cubit/cubit.dart';
import '/layout/social_layout.dart';
import '/modules/auth/auth_screen.dart';
import '/shared/bloc_observer.dart';
import '/shared/constants.dart';
import '/styles/theme_services.dart';
import 'firebase_options.dart';
import 'network/local/cache_helper.dart';
import 'styles/thems.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //===================== Initializing GetStorage =====================
  await GetStorage.init();

  //===================== Observing My Bloc =====================
  Bloc.observer = MyBlocObserver();

  //===================== Initializing SharedPref =====================
  await CacheHelper.initSharedPref();

  uId = CacheHelper.getStringData(key: 'uId');

  Widget startingScreen;

  if (uId != null) {
    startingScreen = const SocialAppLayout();
  } else {
    startingScreen = const AuthScreen();
  }

  runApp(
    MainApp(
      startingScreen,
      uId,
    ),
  );
}

class MainApp extends StatelessWidget {
  final Widget? startingScreen;
  final String? uId;
  const MainApp(
    this.startingScreen,
    this.uId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppCubit()
        ..getUserData(uId)
        ..getPosts(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeServices().theme,
        home: startingScreen,
      ),
    );
  }
}
