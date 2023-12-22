// TODO: auth Loading: Build a Material type.transparent and in the center there's a spinkit loading

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/service_locator.dart';
import 'package:social_app/features/auth/presentation/views/auth_view.dart';
import 'package:social_app/layout/presentation/view/layout_view.dart';
import 'package:social_app/linkup_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await GetStorage.init();

  await ServiceLocator().setup();

  Bloc.observer = MyBlocObserver();

  // Widget startingScreen;

  // if (Helper.uId != null) {
  //   startingScreen = const LayoutView();
  // } else {
  //   startingScreen = const AuthView();
  // }

  runApp(const LinkupApp());
}

// TODO: Add functionality to tags TextButton in NewPostView

