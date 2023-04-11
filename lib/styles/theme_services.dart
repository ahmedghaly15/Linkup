import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//============================= Controlling App Theme =============================
class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = 'isDarkMode';

//============================= Save App Theme =============================
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

//============================= Load App Theme =============================
  bool _loadThemeFromBox() => _box.read<bool>(_key) ?? false;
  // (false means it's light mode)

//============================= Getting App Theme =============================
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

//============================= Switch App Theme =============================
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
