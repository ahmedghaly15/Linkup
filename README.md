# Social-App

This is a new Flutter project. This app is designed to help user connect and interact with friends, family, and other people in a social environment. With its intuitive user interface, users can easily engage with others. The app also features a variety of social interacting tools including create profiles, share photos, and engage in real-time conversations with others.

## Contents

- [Preview](#preview)
- [App Structure](#app-structure)
- [Main File](#main-file)
- [Getting Started](#getting-started)

## Preview

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

## Main File

```
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

```

## Getting Started

This project represents a social app designed to help user communicate with everyone.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
