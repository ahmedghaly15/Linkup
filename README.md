# Social-App

This is a new Flutter project. This app is designed to help users connect and interact with friends, family, and other people in a social environment. With its intuitive user interface, users can easily engage with others. The app also features a variety of social interacting tools including create profiles, share photos, and engage in real-time conversations with others.

## Contents

- [Preview](#preview)
- [App Structure](#app-structure)
- [Features](#features)
- [Main File](#main-file)
- [Getting Started](#getting-started)

## Preview

<div style="display: flex" > 
  <img style="display: inline-block" src="https://github.com/ahmedghaly15/Social-App/assets/108659381/ae5a1813-8e3b-4fac-a28a-e8d90a60c2b3" width= "300" height = "600"/>
</div>

https://github.com/ahmedghaly15/Social-App/assets/108659381/b86b8823-8572-4452-adcf-f3b8a098039a

## App Structure

```

lib
├── layout
│   ├── cubit
│   └── layout_screen.dart
│
├── models
│
├── modules
│   ├── auth
│   │   ├── cubit
│   │   └── auth_screen.dart
│   │
│   ├── feeds
│   │
│   ├── comments
│   │
│   ├── new_post
│   │
│   ├── chats
│   │   ├── chats_screen.dart
│   │   └── chat_details_screen.dart
│   │
│   ├── users
│   │   ├── users_screen.dart
│   │   └── user_profile_screen.dart
│   │
│   ├── profile
│   │
│   └── edit_profile
│
├── network
│   ├── local
│   └──── cache_helper.dart
│
├── shared
│   ├── components
│   ├── bloc_observer.dart
│   └── constants.dart
│
├── styles
│   ├── themes
│   └── theme_services
│
├── firebase_options.dart
│
└── main.dart

```

## Features

- `Create new post`: the app makes it easy and intuitive to create new posts, with the ability to add text, images, and videos to your posts, user can easily share his thoughts and experiences with his friends.
- `Firebase authentication`: The app uses Firebase Authentication to provide secure user authentication and authorization.
- `Cloud firestore1`: The app uses Firebase Cloud Firestore to store users profile images, images they send to each other in chats, and the images shared in feeds.
- `Dark theme`: The app supports a dark theme, which provides a comfortable viewing experience in low-light environments.
- `Real-time messaging`: The app utilizes Firebase Realtime Database to enable real-time messaging, allowing users to communicate with each other instantly.
- `Search`: allows users to find specific conversations or messages within a chat by entering relevant keywords or phrases.
- `Profile customization`: Users have the ability to change their names, bio, profile image, and cover image, allowing them to personalize their account and make it more recognizable to other users.

## Main File

```dart
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
    SocialApp(
      startingScreen,
      uId,
    ),
  );
}

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
    return BlocProvider(
      create: (context) => AppCubit()
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

```

## Getting Started

This project represents a social app designed to help user communicate with everyone.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
