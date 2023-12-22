import 'package:go_router/go_router.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/features/splash/presentation/views/splash_view.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.initialRoute,
      builder: (context, state) => const SplashView(),
    ),
    // GoRoute(path: Routes.loginRoute, builder: (context, state) => )
  ],
);
