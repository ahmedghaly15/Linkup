import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/config/router/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/service_locator.dart';

class EntryView extends StatefulWidget {
  const EntryView({super.key});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  void _goToNext() {
    Helper.uId =
        getIt.get<CacheHelper>().getStringData(key: AppStrings.cachedUserId);

    bool? onBoarding =
        getIt.get<CacheHelper>().getBoolData(key: AppStrings.cachedOnboarding);

    if (onBoarding != null) {
      if (Helper.uId != null) {
        context.navigateAndReplace(
          newRoute: Routes.linkupRoute,
        );
      } else {
        context.navigateAndReplace(newRoute: Routes.signInRoute);
      }
    } else {
      context.navigateAndReplace(newRoute: Routes.onboardingRoute);
    }
  }

  void _setSystemUIOverlayStyle() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void initState() {
    // To ensure that navigation calls are performed after the widget tree has been built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goToNext();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _setSystemUIOverlayStyle();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(),
    );
  }
}
