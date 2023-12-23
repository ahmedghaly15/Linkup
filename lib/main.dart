import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/service_locator.dart';

import 'package:social_app/linkup_app.dart';

// TODO: split comments from feeds feature & make it a feature

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ServiceLocator().setup();

  Bloc.observer = MyBlocObserver();

  runApp(const LinkupApp());
}

// TODO: Add functionality to tags TextButton in NewPostView

