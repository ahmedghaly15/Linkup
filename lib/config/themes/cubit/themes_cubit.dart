import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/themes/app_themes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/service_locator.dart';

class ThemesCubit extends Cubit<ThemeData> {
  ThemesCubit() : super(AppThemes.lightTheme) {
    _getThemeFromPrefs();
  }

  Future<void> _saveThemeToPrefs({required Brightness brightness}) async {
    final themeIndex = brightness == Brightness.light ? 0 : 1;

    await getIt.get<CacheHelper>().saveData(
          key: AppStrings.theme,
          value: themeIndex,
        );
  }

  Future<void> _getThemeFromPrefs() async {
    final savedThemeIndex =
        getIt.get<CacheHelper>().getIntData(key: AppStrings.theme) ?? 0;

    final savedTheme =
        savedThemeIndex == 0 ? AppThemes.lightTheme : AppThemes.darkTheme;

    emit(savedTheme);
  }

  void toggleTheme() {
    emit(state.brightness == Brightness.light
        ? AppThemes.darkTheme
        : AppThemes.lightTheme);

    print('STATE: ${state.brightness.toString()}');

    _saveThemeToPrefs(brightness: state.brightness);
  }
}
