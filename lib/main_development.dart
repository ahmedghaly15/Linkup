import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/service_locator.dart';
import 'package:social_app/linkup_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Bloc.observer = MyBlocObserver();

  await ServiceLocator().setup();

  // To fix texts being hidden bug in release mode
  await ScreenUtil.ensureScreenSize();

  runApp(const LinkupApp());
}
