import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:social_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:social_app/features/splash/presentation/views/splash_view.dart';
import 'package:social_app/home.dart';
import 'package:social_app/service_locator.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case Routes.signInRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<SignInCubit>(),
            child: const SignInView(),
          ),
        );

      case Routes.signUpRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<SignUpCubit>(),
            child: const SignUpView(),
          ),
        );

      case Routes.layoutRoute:
        return MaterialPageRoute(builder: (context) => const HomeView());

      default:
        return unFoundRoute();
    }
  }

  static Route<dynamic> unFoundRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            "Un Found Route",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
