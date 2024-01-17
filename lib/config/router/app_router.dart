import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/features/auth/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:social_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:social_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:social_app/features/chat/presentation/cubits/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/views/chat_details_view.dart';
import 'package:social_app/features/chat/presentation/views/chats_view.dart';
import 'package:social_app/features/comments/domain/entities/comments_view_params.dart';
import 'package:social_app/features/comments/presentation/cubit/comments_cubit.dart';
import 'package:social_app/features/comments/presentation/views/comments_view.dart';
import 'package:social_app/features/entry/presentation/view/entry_view.dart';
import 'package:social_app/features/linkup/presentation/cubits/linkup_cubit.dart';
import 'package:social_app/features/linkup/presentation/views/linkup_view.dart';
import 'package:social_app/features/new_post/presentation/view/new_post_view.dart';
import 'package:social_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:social_app/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:social_app/features/posts/presentation/views/post_likes_view.dart';
import 'package:social_app/features/profile/presentation/cubits/edit_profile_cubit.dart';
import 'package:social_app/features/profile/presentation/views/edit_profile_view.dart';
import 'package:social_app/features/users/presentation/views/user_profile_view.dart';
import 'package:social_app/service_locator.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const EntryView());

      case Routes.onboardingRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
            create: (context) => getIt.get<OnboardingCubit>(),
            child: const OnboardingView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

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

      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<ForgotPasswordCubit>(),
            child: const ForgotPasswordView(),
          ),
        );

      case Routes.newPostRoute:
        return MaterialPageRoute(builder: (context) => const NewPostView());

      case Routes.postLikesRoute:
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => PostLikesView(postId: args),
        );

      case Routes.commentsRoute:
        final args = routeSettings.arguments as CommentsViewParams;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt.get<CommentsCubit>()..getComments(postId: args.postId!),
            child: CommentsView(params: args),
          ),
        );

      case Routes.chatsRoute:
        return MaterialPageRoute(
          builder: (context) => const ChatsView(),
        );

      case Routes.chatDetailsRoute:
        final args = routeSettings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<ChatCubit>(),
            child: ChatDetailsView(user: args),
          ),
        );

      case Routes.userProfileRoute:
        final args = routeSettings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (context) => UserProfileView(user: args),
        );

      case Routes.linkupRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<LinkupCubit>(),
            child: const LinkupView(),
          ),
        );

      case Routes.editProfileRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<EditProfileCubit>(),
            child: const EditProfileView(),
          ),
        );

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
