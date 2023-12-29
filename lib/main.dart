import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/service_locator.dart';

import 'package:social_app/linkup_app.dart';

// TODO: use create post method when you upload the profile image or cover image to share a new post like in facebook
// TODO: Add functionality to tags TextButton in NewPostView

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

  await ServiceLocator().setup();

  runApp(const LinkupApp());
}
