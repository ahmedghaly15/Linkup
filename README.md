# Linkup-App

This is a new Flutter project. This app is designed to help users connect and interact with friends, family, and other people in a social environment. With its intuitive user interface, users can easily engage with others. The app also features a variety of social interacting tools including create profiles, share photos, and engage in real-time conversations with others.

## Contents

- [Preview](#preview)
- [App Structure](#app-structure)
- [Features](#features)
- [Main File](#main-file)
- [Getting Started](#getting-started)

## Preview

<div style="display: flex" > 
  <img style="display: inline-block" src="https://github.com/ahmedghaly15/Social-App/assets/108659381/3cec1455-b2ec-4179-aaf5-4e6f69e1302f" width= "300" height = "600"/>
</div>

https://github.com/ahmedghaly15/Social-App/assets/108659381/1735c2fa-275c-4da4-bf27-bf491e6ef829

## App Structure

```

lib
├── core
│   ├── global
│   ├── models
│   ├── services
│   ├── utils
│   └── widgets
│
├── features
│   ├── auth
│   ├── chat
│   ├── feeds
│   ├── new_post
│   ├── profile
│   └── users
│
├── layout
│   ├── data
│   ├── domain
│   └── presentation
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

  await GetStorage.init();

  ServiceLocator().setupServiceLocators();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.initSharedPref();

  Helper.uId = CacheHelper.getStringData(key: 'uId');

  Widget startingScreen;

  if (Helper.uId != null) {
    startingScreen = const LayoutView();
  } else {
    startingScreen = const AuthView();
  }

  runApp(
    LinkUpApp(
      startingScreen,
      Helper.uId,
    ),
  );
}


class LinkUpApp extends StatelessWidget {
  final Widget? startingScreen;
  final String? uId;
  const LinkUpApp(
    this.startingScreen,
    this.uId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(serviceLocator.get<AppRepo>())
            ..getUserData(uId)
            ..getPosts(),
        ),
        BlocProvider(create: (context) => ThemeService()),
      ],
      child: BlocBuilder<ThemeService, bool>(
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        builder: (context, isDark) {
          return GetMaterialApp(
            title: AppTexts.appTitle,
            debugShowCheckedModeBanner: false,
            theme: isDark ? AppTheme.darkTheme() : AppTheme.lightTheme(),
            home: startingScreen,
          );
        },
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
