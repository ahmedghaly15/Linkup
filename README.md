# Social-App

This is a new Flutter project. This app is designed to help user connect and interact with friends, family, and other people in a social environment. With its intuitive user interface, users can easily engage with others. The app also features a variety of social interacting tools including create profiles, share photos, and engage in real-time conversations with others.

## Preview

https://github.com/ahmedghaly15/Social-App/assets/108659381/db0095a7-0832-4dd5-8547-162b4ac989a3

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

## Getting Started

This project represents a social app designed to help user communicate with everyone.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
