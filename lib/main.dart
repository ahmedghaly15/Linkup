import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/service_locator.dart';

import 'package:social_app/linkup_app.dart';

// TODO: split comments from feeds feature & make it a feature
/*
TODO:  save posts in cache and build a method in posts cubit that check on the internet 
      and if the there's internet execute getPosts(), else execute the method that return the saved posts
 */

// TODO: use create post method when you upload the profile image or cover image to share a new post like in facebook

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

