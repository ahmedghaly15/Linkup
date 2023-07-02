import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/cache_helper.dart';

class ThemeService extends Cubit<bool> {
  ThemeService() : super(false) {
    _loadTheme();
  }

  static ThemeService getObject(context) => BlocProvider.of(context);

  static bool isDark = false;

  Future<void> toggleTheme() async {
    await _saveTheme(!state);
    emit(!state);
  }

  Future<void> _loadTheme() async {
    isDark = CacheHelper.getBoolData(key: 'isDark') ?? false;
    emit(isDark);
  }

  Future<void> _saveTheme(bool isDark) async {
    await CacheHelper.saveData(key: 'isDark', value: isDark);
  }
}
