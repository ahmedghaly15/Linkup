import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/auth/auth_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/constants.dart';

import 'firebase_options.dart';
import 'network/local/cache_helper.dart';
import 'styles/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  const MainApp(this.startingScreen, this.uId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppCubit()..getUserData(uId),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Janna',
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: defaultColor,
              size: 25,
            ),
            titleTextStyle: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 0.5,
              fontFamily: 'Janna',
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: startingScreen,
      ),
    );
  }
}
